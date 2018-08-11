class RemoveTaskTitleFromFiledPlanTitle < ActiveRecord::Migration
  def change
    remove_column :filed_plan_tasks, :task_title
  end
end
