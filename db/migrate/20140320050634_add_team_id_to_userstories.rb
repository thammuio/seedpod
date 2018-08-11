class AddTeamIdToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :team_id, :integer
    add_index :userstories, :team_id
  end
end
