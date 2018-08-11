class AddTeamIdToSubmittedPlans < ActiveRecord::Migration
  def change
    add_column :submitted_plans, :team_id, :integer
  end
end
