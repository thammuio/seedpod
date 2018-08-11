class AddIsApprovedToProductivityReports < ActiveRecord::Migration
  def change
    add_column :productivity_reports, :is_approved, :boolean, :default => false
  end
end
