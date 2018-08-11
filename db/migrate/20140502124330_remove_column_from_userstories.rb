class RemoveColumnFromUserstories < ActiveRecord::Migration
  def change
    remove_column :userstories, :is_approved
    remove_column :userstories, :is_submitted
  end
end
