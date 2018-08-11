class RemoveFeedbackFormFromPlanDetails < ActiveRecord::Migration
  def change
    remove_column :submitted_plandetails, :feedback_body
  end
end
