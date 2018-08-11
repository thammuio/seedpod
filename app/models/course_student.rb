class CourseStudent < ActiveRecord::Base
  belongs_to :student_course
  belongs_to :student
  before_create :set_status_active

  def set_status_active
    self.status = "Active"
  end
end