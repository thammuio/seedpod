class AddStatusAndIsResentToPlanTeams < ActiveRecord::Migration
  def change
    add_column :plan_teams, :status, :string
    add_column :plan_teams, :is_resent, :integer
  end
end
