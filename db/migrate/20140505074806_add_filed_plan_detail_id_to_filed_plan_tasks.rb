class AddFiledPlanDetailIdToFiledPlanTasks < ActiveRecord::Migration
  def change
    add_column :filed_plan_tasks, :filed_plan_detail_id, :integer
  end
end
