class AddIsApprovedToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :is_approved, :boolean, :default => false
  end
end
