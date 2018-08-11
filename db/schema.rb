# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140520062324) do

  create_table "course_students", force: true do |t|
    t.integer  "student_course_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "course_students", ["student_course_id"], name: "index_course_students_on_student_course_id"
  add_index "course_students", ["student_id"], name: "index_course_students_on_student_id"

  create_table "course_teams", force: true do |t|
    t.integer  "team_id"
    t.integer  "student_course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_teams", ["student_course_id"], name: "index_course_teams_on_student_course_id"
  add_index "course_teams", ["team_id"], name: "index_course_teams_on_team_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "filed_plan_details", force: true do |t|
    t.integer  "plan_id"
    t.integer  "student_id"
    t.integer  "team_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plan_title"
    t.string   "title_slug"
    t.string   "slug"
  end

  create_table "filed_plan_tasks", force: true do |t|
    t.text     "description"
    t.decimal  "estimate"
    t.integer  "priority"
    t.integer  "userstory_id"
    t.integer  "team_id"
    t.string   "taksslug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "filed_plan_detail_id"
    t.integer  "parent_task_id"
    t.string   "title"
  end

  create_table "filed_plan_userstories", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "estimate"
    t.integer  "priority"
    t.string   "status"
    t.integer  "filed_plan_detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "userstory_slug"
    t.integer  "parent_userstory_id"
    t.integer  "student_id"
    t.string   "slug"
  end

  add_index "filed_plan_userstories", ["filed_plan_detail_id"], name: "index_filed_plan_userstories_on_filed_plan_detail_id"

  create_table "filed_productivity_report_details", force: true do |t|
    t.integer  "productivity_report_id"
    t.integer  "student_id"
    t.integer  "team_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report_title"
    t.string   "slug"
  end

  create_table "filed_productivity_report_tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "estimate"
    t.integer  "priority"
    t.integer  "userstory_id"
    t.integer  "team_id"
    t.string   "taskslug"
    t.integer  "filed_productivity_report_detail_id"
    t.integer  "parent_task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userstory_task_assigned_to"
    t.string   "days_worked"
    t.string   "status"
  end

  create_table "filed_productivity_report_userstories", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "estimate"
    t.integer  "priority"
    t.string   "status"
    t.integer  "filed_productivity_report_detail_id"
    t.string   "userstory_slug"
    t.integer  "parent_userstory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "plan_teams", force: true do |t|
    t.integer  "plan_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "is_resent"
  end

  add_index "plan_teams", ["plan_id"], name: "index_plan_teams_on_plan_id"
  add_index "plan_teams", ["team_id"], name: "index_plan_teams_on_team_id"

  create_table "plans", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "student_course_id"
    t.integer  "team_id"
    t.string   "slug"
    t.boolean  "is_approved"
  end

  add_index "plans", ["slug"], name: "index_plans_on_slug", unique: true
  add_index "plans", ["student_course_id"], name: "index_plans_on_student_course_id"
  add_index "plans", ["team_id"], name: "index_plans_on_team_id"
  add_index "plans", ["user_id"], name: "index_plans_on_user_id"

  create_table "productivity_report_teams", force: true do |t|
    t.integer  "productivity_report_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_resent"
    t.string   "status"
  end

  add_index "productivity_report_teams", ["productivity_report_id"], name: "index_productivity_report_teams_on_productivity_report_id"
  add_index "productivity_report_teams", ["team_id"], name: "index_productivity_report_teams_on_team_id"

  create_table "productivity_reports", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "student_course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "is_approved",       default: false
  end

  add_index "productivity_reports", ["slug"], name: "index_productivity_reports_on_slug", unique: true
  add_index "productivity_reports", ["student_course_id"], name: "index_productivity_reports_on_student_course_id"

  create_table "student_courses", force: true do |t|
    t.integer  "user_id"
    t.string   "course_name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "course_id"
    t.text     "description"
    t.string   "slug"
  end

  add_index "student_courses", ["slug"], name: "index_student_courses_on_slug", unique: true
  add_index "student_courses", ["team_id"], name: "index_student_courses_on_team_id"
  add_index "student_courses", ["user_id"], name: "index_student_courses_on_user_id"

  create_table "student_teams", force: true do |t|
    t.integer  "student_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_teams", ["student_id"], name: "index_student_teams_on_student_id"
  add_index "student_teams", ["team_id"], name: "index_student_teams_on_team_id"

  create_table "students", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "password"
    t.string   "student_name"
    t.string   "password_salt"
    t.string   "psd"
    t.text     "address"
    t.integer  "mobile_no"
    t.boolean  "is_pwd_change"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id"

  create_table "submitted_plandetails", force: true do |t|
    t.integer  "userstory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "submitted_plan_id"
    t.integer  "task_id"
    t.decimal  "estimated_time"
    t.integer  "userstory_task_estimate_assigned_to"
    t.integer  "plan_updated_by_student"
  end

  add_index "submitted_plandetails", ["submitted_plan_id"], name: "index_submitted_plandetails_on_submitted_plan_id"
  add_index "submitted_plandetails", ["task_id"], name: "index_submitted_plandetails_on_task_id"
  add_index "submitted_plandetails", ["userstory_id"], name: "index_submitted_plandetails_on_userstory_id"

  create_table "submitted_plans", force: true do |t|
    t.integer  "plan_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_updated_by_student"
    t.text     "feedback_body"
    t.integer  "team_id"
  end

  add_index "submitted_plans", ["plan_id"], name: "index_submitted_plans_on_plan_id"
  add_index "submitted_plans", ["student_id"], name: "index_submitted_plans_on_student_id"

  create_table "submitted_report_details", force: true do |t|
    t.integer  "submitted_report_id"
    t.integer  "userstory_id"
    t.integer  "task_id"
    t.float    "time_worked"
    t.integer  "userstory_task_assigned_to"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submitted_report_details", ["submitted_report_id"], name: "index_submitted_report_details_on_submitted_report_id"
  add_index "submitted_report_details", ["task_id"], name: "index_submitted_report_details_on_task_id"
  add_index "submitted_report_details", ["userstory_id"], name: "index_submitted_report_details_on_userstory_id"

  create_table "submitted_reports", force: true do |t|
    t.integer  "productivity_report_id"
    t.integer  "student_id"
    t.integer  "report_updated_by_student"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "feedback_body"
  end

  add_index "submitted_reports", ["productivity_report_id"], name: "index_submitted_reports_on_productivity_report_id"
  add_index "submitted_reports", ["student_id"], name: "index_submitted_reports_on_student_id"

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "estimate"
    t.integer  "priority"
    t.integer  "userstory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.string   "taksslug"
    t.boolean  "is_approved",  default: false
    t.string   "slug"
  end

  add_index "tasks", ["team_id"], name: "index_tasks_on_team_id"
  add_index "tasks", ["userstory_id"], name: "index_tasks_on_userstory_id"

  create_table "teams", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", unique: true
  add_index "teams", ["user_id"], name: "index_teams_on_user_id"

  create_table "us_teams", force: true do |t|
    t.integer  "team_id"
    t.integer  "userstory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "us_teams", ["team_id"], name: "index_us_teams_on_team_id"
  add_index "us_teams", ["userstory_id"], name: "index_us_teams_on_userstory_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "user_type_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_no"
    t.text     "address"
    t.boolean  "is_admin"
    t.string   "username"
    t.boolean  "chng_pwd"
    t.string   "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id"

  create_table "userstories", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "estimate"
    t.integer  "priority"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
    t.integer  "course_id"
    t.integer  "team_id"
    t.string   "userstory_slug"
    t.string   "slug"
    t.boolean  "in_submitted",   default: false
  end

  add_index "userstories", ["student_id"], name: "index_userstories_on_student_id"
  add_index "userstories", ["team_id"], name: "index_userstories_on_team_id"

end
