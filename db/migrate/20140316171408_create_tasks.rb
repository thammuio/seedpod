class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :estimate
      t.integer :priority
      t.integer :userstory_id

      t.timestamps
    end
    add_index :tasks, :userstory_id
  end
end
