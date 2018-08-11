class AddIsApprovedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :is_approved, :boolean, :default => false
  end
end
