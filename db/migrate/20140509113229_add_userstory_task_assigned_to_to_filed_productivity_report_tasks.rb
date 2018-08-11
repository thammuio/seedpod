class AddUserstoryTaskAssignedToToFiledProductivityReportTasks < ActiveRecord::Migration
  def change
    add_column :filed_productivity_report_tasks, :userstory_task_assigned_to, :integer
  end
end
