class AddUserstoryTaskEstimateAssignedToToSubmittedPlandetails < ActiveRecord::Migration
  def change
    add_column :submitted_plandetails, :userstory_task_estimate_assigned_to, :integer
  end
end
