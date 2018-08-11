class AddReportTitleAndSlugToFiledProductivityReportDetails < ActiveRecord::Migration
  def change
    add_column :filed_productivity_report_details, :report_title, :string
    add_column :filed_productivity_report_details, :slug, :string
  end
end
