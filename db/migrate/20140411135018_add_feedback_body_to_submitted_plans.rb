class AddFeedbackBodyToSubmittedPlans < ActiveRecord::Migration
  def change
    add_column :submitted_plans, :feedback_body, :text
  end
end
