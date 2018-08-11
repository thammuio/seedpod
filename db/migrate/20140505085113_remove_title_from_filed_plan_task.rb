class RemoveTitleFromFiledPlanTask < ActiveRecord::Migration
  def change
    remove_column :filed_plan_tasks, :title
  end
end
