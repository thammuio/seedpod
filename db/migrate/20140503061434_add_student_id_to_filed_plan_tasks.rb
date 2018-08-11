class AddStudentIdToFiledPlanTasks < ActiveRecord::Migration
  def change
    add_column :filed_plan_tasks, :student_id, :integer
  end
end
