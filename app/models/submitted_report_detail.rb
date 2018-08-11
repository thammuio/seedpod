class SubmittedReportDetail < ActiveRecord::Base
  belongs_to :submitted_report

  ReportStatus = [ "In progress", "Completed", "None" ]
end