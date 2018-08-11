class AddStatusToCourseStudents < ActiveRecord::Migration
  def change
    add_column :course_students, :status, :string
  end
end
