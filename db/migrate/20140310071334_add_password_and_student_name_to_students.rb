class AddPasswordAndStudentNameToStudents < ActiveRecord::Migration
  def change
    add_column :students, :password, :string
    add_column :students, :student_name, :string
  end
end
