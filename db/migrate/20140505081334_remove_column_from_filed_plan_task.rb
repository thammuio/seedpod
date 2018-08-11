class RemoveColumnFromFiledPlanTask < ActiveRecord::Migration
  def change
    remove_column :filed_plan_tasks, :student_id
    remove_column :filed_plan_tasks, :filed_plan_userstory_id
  end
end
