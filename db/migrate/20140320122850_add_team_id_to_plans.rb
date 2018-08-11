class AddTeamIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :team_id, :integer
    add_index :plans, :team_id
  end
end
