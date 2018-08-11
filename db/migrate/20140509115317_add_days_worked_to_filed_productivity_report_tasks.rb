class AddDaysWorkedToFiledProductivityReportTasks < ActiveRecord::Migration
  def change
    add_column :filed_productivity_report_tasks, :days_worked, :string
  end
end
