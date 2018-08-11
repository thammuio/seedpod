class AddIsApprovedToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :is_approved, :boolean, :default => false
  end
end
