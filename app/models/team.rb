class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :course_teams
  has_many :student_courses, through: :course_teams

  belongs_to :plan
  belongs_to :user

  has_many :plan_teams
  has_many :plans, through: :plan_teams

  has_many :productivity_report_teams
  has_many :productivity_reports, through: :productivity_report_teams

  has_many :student_teams
  has_many :students, through: :student_teams

  has_many :userstories

  accepts_nested_attributes_for :student_teams
  accepts_nested_attributes_for :course_teams
end
