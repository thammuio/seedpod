class FiledProductivityReportDetail < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :report_title, use: :slugged

  has_many :filed_productivity_report_userstories
  has_many :filed_productivity_report_tasks
end
