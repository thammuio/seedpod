class CreatePlanTeams < ActiveRecord::Migration
  def change
    create_table :plan_teams do |t|
      t.belongs_to :plan
      t.belongs_to :team
      t.timestamps
    end
    add_index :plan_teams, :plan_id
    add_index :plan_teams, :team_id
  end
end
