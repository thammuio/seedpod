class RenameCourseIdToStudentCourseId < ActiveRecord::Migration
  def change
    rename_column :productivity_reports, :course_id, :student_course_id
    add_index :productivity_reports, :student_course_id
  end
end
