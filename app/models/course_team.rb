class CourseTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :student_course
end
