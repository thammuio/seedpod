class CreateSubmittedPlans < ActiveRecord::Migration
  def change
    create_table :submitted_plans do |t|
      t.integer :plan_id
      t.integer :userstory_id
      t.integer :task_id
      t.decimal :estimated_time
      t.integer :student_id

      t.timestamps
    end
    add_index :submitted_plans, :plan_id
    add_index :submitted_plans, :student_id
  end
end
