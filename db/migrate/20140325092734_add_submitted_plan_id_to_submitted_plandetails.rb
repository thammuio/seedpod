class AddSubmittedPlanIdToSubmittedPlandetails < ActiveRecord::Migration
  def change
    add_column :submitted_plandetails, :submitted_plan_id, :integer
    add_index :submitted_plandetails, :submitted_plan_id
  end
end
