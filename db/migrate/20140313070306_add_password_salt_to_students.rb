class AddPasswordSaltToStudents < ActiveRecord::Migration
  def change
    add_column :students, :password_salt, :string
  end
end
