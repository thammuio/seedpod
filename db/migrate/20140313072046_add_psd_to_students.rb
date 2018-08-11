class AddPsdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :psd, :string
  end
end
