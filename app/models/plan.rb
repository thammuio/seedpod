class Plan < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  has_many :plan_teams
  has_many :teams, through: :plan_teams

  belongs_to :student_course
  validates :title, presence: true
end