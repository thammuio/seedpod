class AddTaskTitleToFiledPlanTasks < ActiveRecord::Migration
  def change
    add_column :filed_plan_tasks, :task_title, :string
  end
end
