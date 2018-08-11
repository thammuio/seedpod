class CreateSubmittedPlandetails < ActiveRecord::Migration
  def change
    create_table :submitted_plandetails do |t|
      t.integer :userstory_id

      t.timestamps
    end
    add_index :submitted_plandetails, :userstory_id
  end
end
