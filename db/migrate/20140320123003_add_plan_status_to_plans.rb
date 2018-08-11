class AddPlanStatusToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :plan_status, :string
  end
end
