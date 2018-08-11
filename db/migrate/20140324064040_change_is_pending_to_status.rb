class ChangeIsPendingToStatus < ActiveRecord::Migration
  def change
    rename_column :plans, :is_pending, :status
  end
end
