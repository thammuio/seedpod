class AddInSubmittedToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :in_submitted, :boolean, :default => false
  end
end
