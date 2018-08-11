class RemovePlanStatusFromPlans < ActiveRecord::Migration
  def change
    remove_column :plans, :plan_status
  end
end
