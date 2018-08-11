class CreateFiledProductivityReportUserstories < ActiveRecord::Migration
  def change
    create_table :filed_productivity_report_userstories do |t|
      t.string :title
      t.text :description
      t.decimal :estimate
      t.integer :priority
      t.string :status
      t.integer :filed_productivity_report_detail_id
      t.string :userstory_slug
      t.integer :parent_userstory_id

      t.timestamps
    end
  end
end
