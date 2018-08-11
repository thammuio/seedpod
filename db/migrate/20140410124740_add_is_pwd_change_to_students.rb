class AddIsPwdChangeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :is_pwd_change, :boolean
  end
end
