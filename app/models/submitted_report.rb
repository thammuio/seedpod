class SubmittedReport < ActiveRecord::Base
  has_many :submitted_report_details #, :dependent => :destroy
  accepts_nested_attributes_for :submitted_report_details, :allow_destroy => true
end
