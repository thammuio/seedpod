class CreateSubmittedReports < ActiveRecord::Migration
  def change
    create_table :submitted_reports do |t|
      t.integer :productivity_report_id
      t.integer :student_id
      t.integer :report_updated_by_student

      t.timestamps
    end
    add_index :submitted_reports, :productivity_report_id
    add_index :submitted_reports, :student_id
  end
end
