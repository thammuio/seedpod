class AddIsPendingToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :is_pending, :boolean
  end
end
