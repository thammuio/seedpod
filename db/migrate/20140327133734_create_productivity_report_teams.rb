class CreateProductivityReportTeams < ActiveRecord::Migration
  def change
    create_table :productivity_report_teams do |t|
      t.belongs_to :productivity_report
      t.belongs_to :team
      t.timestamps
    end
    add_index :productivity_report_teams, :productivity_report_id
    add_index :productivity_report_teams, :team_id
  end
end
