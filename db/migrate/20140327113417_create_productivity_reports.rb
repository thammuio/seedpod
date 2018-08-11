class CreateProductivityReports < ActiveRecord::Migration
  def change
    create_table :productivity_reports do |t|
      t.string :title
      t.text :description
      t.integer :course_id

      t.timestamps
    end
  end
end
