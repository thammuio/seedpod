class RemoveColumnsFromSubmittedPlans < ActiveRecord::Migration
  def change
    remove_column :submitted_plans, :task_id
  end
end
