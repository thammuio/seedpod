class AddPlanUpdatedByStudentToSubmittedPlandetails < ActiveRecord::Migration
  def change
    add_column :submitted_plandetails, :plan_updated_by_student, :integer
  end
end
