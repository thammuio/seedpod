class CreateFiledPlanDetails < ActiveRecord::Migration
  def change
    create_table :filed_plan_details do |t|
      t.integer :plan_id
      t.integer :student_id
      t.integer :team_id
      t.integer :course_id

      t.timestamps
    end
  end
end
