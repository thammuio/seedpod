class AddStudentIdToFiledPlanUserstories < ActiveRecord::Migration
  def change
    add_column :filed_plan_userstories, :student_id, :integer
  end
end
