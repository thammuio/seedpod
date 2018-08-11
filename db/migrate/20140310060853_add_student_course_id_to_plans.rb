class AddStudentCourseIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :student_course_id, :integer
    add_index :plans, :student_course_id
  end
end
