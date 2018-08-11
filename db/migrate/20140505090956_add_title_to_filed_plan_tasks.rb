class AddTitleToFiledPlanTasks < ActiveRecord::Migration
  def change
    add_column :filed_plan_tasks, :title, :string
  end
end
