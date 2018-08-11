class Task < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged


  belongs_to :userstory
  
  validates :title, :description, :estimate, :priority, :presence => true
  TaskPriority = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]

    $i = 0.5
    $num = 10

    TaskEstimate = []
    while $i <= $num  do
      TaskEstimate << $i
      $i +=0.5
    end

  def set_task_slug
    self.taksslug = title.downcase.gsub(" ", "-")
  end
end