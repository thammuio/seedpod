class CreateFiledUserstories < ActiveRecord::Migration
  def change
    create_table :filed_userstories do |t|
      t.string :title
      t.text :description
      t.decimal :estimate
      t.integer :priority
      t.string :status
      t.integer :student_id
      t.integer :course_id
      t.integer :team_id
      t.integer :userstory_id

      t.timestamps
    end
  end
end
