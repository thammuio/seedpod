class AddFeedbackBodyToSubmittedReports < ActiveRecord::Migration
  def change
    add_column :submitted_reports, :feedback_body, :text
  end
end
