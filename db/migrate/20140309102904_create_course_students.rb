class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|
      t.belongs_to :student_course
      t.belongs_to :student
      t.timestamps
    end
    add_index :course_students, :student_course_id
    add_index :course_students, :student_id
  end
end
