class AddTaskslugToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :taksslug, :string
  end
end
