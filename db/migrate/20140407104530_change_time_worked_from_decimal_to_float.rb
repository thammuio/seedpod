class ChangeTimeWorkedFromDecimalToFloat < ActiveRecord::Migration
  def self.up
    change_column :submitted_report_details, :time_worked, :float
  end

  def self.down
    change_column :submitted_report_details, :time_worked, :decimal
  end
end