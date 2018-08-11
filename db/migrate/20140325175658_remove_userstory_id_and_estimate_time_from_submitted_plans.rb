class RemoveUserstoryIdAndEstimateTimeFromSubmittedPlans < ActiveRecord::Migration
  def change
    remove_column :submitted_plans, :userstory_id
    remove_column :submitted_plans, :estimated_time
  end
end
