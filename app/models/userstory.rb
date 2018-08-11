class Userstory < ActiveRecord::Base
  # belongs_to :student
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :students
  has_many :tasks , dependent: :destroy

  belongs_to :team

  UserstoryStatus = ["None", "Incomplete", "Complete"]
  UserstoryPriority = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]

  validates :title, :description, :estimate, :status, :priority, presence: true
  $i = 0.5
  $num = 10

  UserstoryEstimate = []
  while $i <= $num  do
    UserstoryEstimate << $i
    $i +=0.5
  end
end