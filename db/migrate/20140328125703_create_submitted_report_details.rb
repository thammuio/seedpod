class CreateSubmittedReportDetails < ActiveRecord::Migration
  def change
    create_table :submitted_report_details do |t|
      t.integer :submitted_report_id
      t.integer :userstory_id
      t.integer :task_id
      t.decimal :time_worked
      t.integer :userstory_task_assigned_to
      t.string :status

      t.timestamps
    end
    add_index :submitted_report_details, :submitted_report_id
    add_index :submitted_report_details, :userstory_id
    add_index :submitted_report_details, :task_id
  end
end
