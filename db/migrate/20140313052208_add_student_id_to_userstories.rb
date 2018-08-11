class AddStudentIdToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :student_id, :integer
    add_index :userstories, :student_id
  end
end
