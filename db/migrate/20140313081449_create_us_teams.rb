class CreateUsTeams < ActiveRecord::Migration
  def change
    create_table :us_teams do |t|
      t.belongs_to :team
      t.belongs_to :userstory
      t.timestamps
    end
    add_index :us_teams, :team_id
    add_index :us_teams, :userstory_id
  end
end
