class CreateFiledProductivityReportTasks < ActiveRecord::Migration
  def change
    create_table :filed_productivity_report_tasks do |t|
      t.string :title
      t.text :description
      t.decimal :estimate
      t.integer :priority
      t.integer :userstory_id
      t.integer :team_id
      t.string :taskslug
      t.integer :filed_productivity_report_detail_id
      t.integer :parent_task_id

      t.timestamps
    end
  end
end
