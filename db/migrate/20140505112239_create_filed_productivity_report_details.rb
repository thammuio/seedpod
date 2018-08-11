class CreateFiledProductivityReportDetails < ActiveRecord::Migration
  def change
    create_table :filed_productivity_report_details do |t|
      t.integer :productivity_report_id
      t.integer :student_id
      t.integer :team_id
      t.integer :course_id

      t.timestamps
    end
  end
end
