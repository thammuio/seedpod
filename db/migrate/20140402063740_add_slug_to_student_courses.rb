class AddSlugToStudentCourses < ActiveRecord::Migration
  def change
    add_column :student_courses, :slug, :string
    add_index :student_courses, :slug, :unique => true
  end
end
