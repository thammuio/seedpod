class ProductivityReport < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :student_course

  has_many :productivity_report_teams
  has_many :teams, through: :productivity_report_teams

  end