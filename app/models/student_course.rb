class StudentCourse < ActiveRecord::Base
  extend FriendlyId
  friendly_id :course_name, use: :slugged

  has_many :course_teams
  has_many :teams, through: :course_teams

  belongs_to :user

  has_many :course_students
  has_many :student, through: :course_students

  has_many :plans
  has_many :productivity_reports

  accepts_nested_attributes_for :course_students
  accepts_nested_attributes_for :course_teams

  # Validations
    validates :course_name, :description, :course_id, :presence => true, :uniqueness => true
end