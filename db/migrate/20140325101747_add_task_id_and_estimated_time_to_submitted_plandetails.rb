class AddTaskIdAndEstimatedTimeToSubmittedPlandetails < ActiveRecord::Migration
  def change
    add_column :submitted_plandetails, :task_id, :integer
    add_column :submitted_plandetails, :estimated_time, :decimal
    add_index :submitted_plandetails, :task_id
  end
end
