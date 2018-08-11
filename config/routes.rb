Seedpod::Application.routes.draw do
  root :to => "home#index"
  # Faculty Routes

    resources :student_courses do
      resources :students
      resources :teams
      resources :plans
      resources :productivity_reports
    end

    devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations", :passwords => "passwords" }, :path => '', :path_names => { :sign_up => "/faculty/registration/", :sign_in => 'faculty/login', :sign_out => 'logout' }

    resources :password_resets

    resource :user, only: [:edit] do
      collection do
        patch 'update'
        patch 'update_password'
      end
      match '/profile' => "users#edit_profile", :as => :profile ,via: [:get]
    end

    match "faculty" =>"application#user", :as => :faculty_show, via: [:get]
    match "admin" =>"application#admin", :as => :admin_dashboard, via: [:get]

  # User activation/deactivtion route
    match "admin/deactivate/:id" => "application#deactivate", :as => :deactivate, via: [:get]
    match "admin/activate/:id" => "application#activate", :as => :activate, via: [:get]

  # student routes

    # match "student-profile" => "student_session#edit_student_profile", :as => :edit_student_profile, via: [:get]
    match "course/:id/teams/:slug/userstories" =>"userstories#index", :as => :userstories, via: [:get]
    match "course/:id/teams/:slug/userstories/new" =>"userstories#new", :as => :new_userstory, via: [:get]
    match "course/:id/teams/:slug/userstories" =>"userstories#create", :as => :create_userstory, via: [:post]
    match "course/:id/teams/:slug/userstories/:title" =>"userstories#show", :as => :userstory, via: [:get]
    match "course/:id/teams/:slug/userstories/:title/edit" =>"userstories#edit", :as => :edit_userstory, via: [:get]
    match "course/:id/teams/:slug/userstories/:title" =>"userstories#update", :as => :update_userstory, via: [:put, :patch]
    match "course/:id/teams/:slug/userstories/:title/destroy" =>"userstories#destroy", :as => :destroy_userstory, via: [:delete]

    # match "course/:id/teams/:name/userstories/:title/fedit" =>"userstories#filed_edit_userstories", :as => :filed_edit_userstory, via: [:get]
    # match "course/:id/teams/:name/userstories/filed/:title" =>"userstories#update_filed_userstory", :as => :update_filed_userstory, via: [:put, :patch]

  # Task routes for userstories

    match "/teams/:slug/userstories/:title/tasks" =>"tasks#index", :as => :tasks, via: [:get]
    match "/teams/:slug/userstories/:title/tasks/new" =>"tasks#new", :as => :new_task, via: [:get]
    match "/teams/:slug/userstories/:title/tasks" =>"tasks#create", :as => :create_tasks, via: [:post]
    match "/teams/:slug/userstories/:title/tasks/:taksslug/edit" =>"tasks#edit", :as => :edit_tasks, via: [:get]
    match "/teams/:slug/userstories/:title/tasks/:taksslug" =>"tasks#show", :as => :task, via: [:get]
    match "/teams/:slug/userstories/:title/update/:taksslug" =>"tasks#update", :as => :update_task, via: [:post, :patch]
    match "/teams/:slug/userstories/:title/task/:taksslug/destroy" =>"tasks#destroy", :as => :destroy_task, via: [:delete]

    resources :userstories, :except => [:new, :create, :destroy, :show, :edit, :update, :index] do
      # resources :tasks
    end

#   Request plan by students route
      resources :submitted_plans, :except => [:new, :create, :index, :edit, :update]

      match "course/:id/teams/:name/plan/:title/submit" =>"submitted_plans#new", :as => :new_submitted_plan, via: [:get]
      match "course/:id/teams/:name/plan/:title" =>"submitted_plans#create", :as => :create_submitted_plan, via: [:post]
      match "course/:id/teams/:name/plan/:title/pendings" =>"submitted_plans#index", :as => :submitted_plans, via: [:get]
      match "course/:id/teams/:name/plan/:title/edit-plan" =>"submitted_plans#edit", :as => :edit_submitted_plan, via: [:get]
      match "course/:id/teams/:name/plan/:title" =>"submitted_plans#update", :as => :update_submitted_plan, via: [:post, :patch]

# Submitted report by student route
      resources :submitted_reports, :except => [:new, :create, :index, :edit, :update]

      match "course/:id/teams/:name/report/:title/submit" =>"submitted_reports#new", :as => :new_submitted_report, via: [:get]
      match "course/:id/teams/:name/report/:title" =>"submitted_reports#create", :as => :create_submitted_report , via: [:post]
      match "course/:id/teams/:name/report/:title/pendings" =>"submitted_reports#index", :as => :submitted_reports, via: [:get]
      match "course/:id/teams/:name/report/:title/edit-report" =>"submitted_reports#edit", :as => :edit_submitted_report, via: [:get]
      match "course/:id/teams/:name/report/:title" =>"submitted_reports#update", :as => :update_submitted_report, via: [:post, :patch]


#   resources :tasks

    match "student-report" =>"application#report", :as => :report, via: [:get]
    match "student/login" => "student_session#new", :as => :student_login, via: [ :get ]
    match "student" => "student_session#create", :as => :student_session_create, via: [ :post ]
    match "student/destroy" => "student_session#destroy", :as => :destroy_session, via: [ :delete ]
    match "student/:id" => "student_session#courses", :as => :courses, via: [ :get ]
    match "student/:id/course/:course_name/" => "student_welcomes#course_wise_menus", :as => :course_wise_menus, via: [ :get ]

    match "course/:id/teams/:name/plan/:title/change_post" => "submitted_plans#change_post", :as => :change_post, via: [:post]

  # pending plans to students
    match "course/:id/teams/:slug/pending-plans" => "plans#student_pending_plans", :as => :student_pending_plans, via: [ :get ]
    match "course/:id/pending-plans-to-approve" => "plans#faculty_pending_plans_to_approve", :as => :faculty_pending_plans_to_approve, via: [ :get ]

  # pending reports to students

    match "course/:id/teams/:slug/pending-report" => "student_pending_report#pending_report", :as => :student_pending_report, via: [:get]
    match "course/:id/pending-reports-to-approve" => "productivity_reports#faculty_pending_reports_to_approve", :as => :faculty_pending_reports_to_approve, via: [ :get ]

  # pending plans to approve by faculty routes

    match "/course/:id/team/:name/plan/:title/resend" => "pending_plan_approve#resend", :as => :resend_pending_plan, via: [:post]
    match "/course/:id/team/:name/plan/:title/approve" => "pending_plan_approve#approve", :as => :approve_pending_plan, via: [:get]
    match "/course/:id/team/:name/plan/:title/approve-pending-plan" => "pending_plan_approve#view_plan", :as => :view_plan, via: [:get]

  # faculty and student approved plan page  
    match "/course/:id/team/:name/plan/:slug/filed-plan" => "pending_plan_approve#view_filed_plan", :as => :view_filed_plan, via: [:get]
    match "/course/:id/team/:name/report/:slug/filed-report" => "pending_report_approve#view_filed_report", :as => :view_filed_report, via: [:get]

    match "/course/:id/team/:name/plan/:title/story/:userstory_slug/view-plan-story" => "filed_plan_details#view_filed_plan_userstory", :as => :view_filed_plan_userstory, via: [:get]
    match "/course/:id/team/:name/plan/:title/task/:taksslug/view-plan-task" => "filed_plan_details#view_filed_plan_task", :as => :view_filed_plan_task, via: [:get]

    match "/course/:id/team/:name/report/:title/story/:userstory_slug/view-report-story" => "filed_productivity_report_details#view_filed_productivity_report_userstory", :as => :view_filed_productivity_report_userstory, via: [:get]
    match "/course/:id/team/:name/report/:title/task/:taskslug/view-report-task" => "filed_productivity_report_details#view_filed_productivity_report_task", :as => :view_filed_productivity_report_task, via: [:get]

  # pending reports to approve by faculty routes

    match "/course/:id/team/:slug/report/:title/approve-pending-report" => "pending_report_approve#view_report", :as => :view_report, via: [:get]
    match "/course/:id/team/:slug/report/:title/resend" => "pending_report_approve#resend", :as => :resend_pending_report, via: [:post]
    match "/course/:id/team/:slug/report/:title/approve" => "pending_report_approve#approve", :as => :approve_pending_report, via: [:get]

  # faculty and student approved plan page

  # Filled plan/report routes faculty
    match "course/:id/filed-report" => "pending_report_approve#faculty_filed_report", :as => :faculty_filed_report, via: [ :get ]
    match "course/:id/teams/:slug/filed-report" => "pending_report_approve#filed_report", :as => :filed_report, via: [ :get ]

    match "course/:id/filed-plan" => "pending_plan_approve#faculty_filed_plan", :as => :faculty_filed_plan, via: [ :get ]
    match "course/:id/teams/:name/filed-plan" => "pending_plan_approve#filed_plan", :as => :filed_plan, via: [ :get ]

  # Filled plan/report routes students
    # match "course/:id/teams/:name/filed-plan" => "pending_plan_approve#filed_plan", :as => :filed_plan, via: [ :get ]

  # Student Edit profile route
    match ':id/profile' => "student_profile#edit_profile", :as => :edit_student_profile ,via: [:get]
    match '/change-password' => "student_profile#change_password", :as => :change_password ,via: [:get]

    match 'profiles' => "student_profile#profile", :as => :student_profile ,via: [ :post, :patch ]
    match 'student-password' => "student_profile#update_student_password", :as => :update_student_password ,via: [ :post, :patch ]

    # match 'profiles' => "student_profile#profile", :as => :student_profile ,via: [ :post, :patch ]

  # Report Routes
    match "/course/:id/report" => "report#generate_report", :as => :generate_report, via: [:get]
    get "report/view_report"


  # Report Student Routes
    match "course/:id/teams/:slug/report" => "report#student_report", :as => :student_report, via: [:get]
    # get "report/view_report"


  # Student Activated/Deactivated routes
    match "course/:id/student/:student_name/deactivate" => "students#deactivate", :as => :deactivate_student, via: [:get]
    match "course/:id/student/:student_name/activate" => "students#activate", :as => :activate_student, via: [:get]


  # Student Exist Routes
    post 'check_student_exist_for_course' => 'students#check_student_exist_for_course'

  # Error Routes
    if Rails.env.production?
      get '404', :to => 'application#page_not_found'
      get '422', :to => 'application#server_error'
      get '500', :to => 'application#server_error'
    end
    match '/clearSession' => 'application#session_clear', :as => :session_clear, :via => [ :post, :patch ]
end