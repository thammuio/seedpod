class AddCourseIdAndDescriptionToStudentCourses < ActiveRecord::Migration
  def change
    add_column :student_courses, :course_id, :string
    add_column :student_courses, :description, :text
  end
end
