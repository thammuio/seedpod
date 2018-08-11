class AddIsResentAndStatusToProductivityReportTeams < ActiveRecord::Migration
  def change
    add_column :productivity_report_teams, :is_resent, :integer
    add_column :productivity_report_teams, :status, :string
  end
end
