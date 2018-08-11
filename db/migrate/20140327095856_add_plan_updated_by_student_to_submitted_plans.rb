class AddPlanUpdatedByStudentToSubmittedPlans < ActiveRecord::Migration
  def change
    add_column :submitted_plans, :plan_updated_by_student, :integer
  end
end
