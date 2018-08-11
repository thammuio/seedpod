class AddFeedbackBodyToSubmittedPlandetails < ActiveRecord::Migration
  def change
    add_column :submitted_plandetails, :feedback_body, :text
  end
end
