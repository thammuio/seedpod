class AddIsSubmittedToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :is_submitted, :boolean, :default => "false"
  end
end
