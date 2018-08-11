class AddStatusToFiledProductivityReportTasks < ActiveRecord::Migration
  def change
    add_column :filed_productivity_report_tasks, :status, :string
  end
end
