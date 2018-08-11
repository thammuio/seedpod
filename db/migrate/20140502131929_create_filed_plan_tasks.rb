class CreateFiledPlanTasks < ActiveRecord::Migration
  def change
    create_table :filed_plan_tasks do |t|
      t.string :title
      t.text :description
      t.decimal :estimate
      t.integer :priority
      t.integer :userstory_id
      t.integer :team_id
      t.string :taksslug
      t.integer :filed_plan_userstory_id

      t.timestamps
    end
  end
end
