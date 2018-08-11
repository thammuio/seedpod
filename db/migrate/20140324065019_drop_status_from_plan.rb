class DropStatusFromPlan < ActiveRecord::Migration
  def change
    remove_column :plans, :status
  end
end
