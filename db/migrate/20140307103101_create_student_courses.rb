class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.integer :user_id
      t.string :course_name
      t.integer :team_id

      t.timestamps
    end
    add_index :student_courses, :user_id
    add_index :student_courses, :team_id
  end
end
