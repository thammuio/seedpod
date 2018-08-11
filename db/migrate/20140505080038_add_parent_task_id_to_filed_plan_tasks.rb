class AddParentTaskIdToFiledPlanTasks < ActiveRecord::Migration
  def change
    add_column :filed_plan_tasks, :parent_task_id, :integer
  end
end
