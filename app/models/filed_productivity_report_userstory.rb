class FiledProductivityReportUserstory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :filed_productivity_report_detail
end
