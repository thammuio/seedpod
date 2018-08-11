class CreateFiledPlanUserstories < ActiveRecord::Migration
  def change
    create_table :filed_plan_userstories do |t|
      t.string :title
      t.text :description
      t.decimal :estimate
      t.integer :priority
      t.string :status
      t.integer :filed_plan_detail

      t.timestamps
    end
  end
end
