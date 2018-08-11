class CreateUserstories < ActiveRecord::Migration
  def change
    create_table :userstories do |t|
      t.string :title
      t.text :description
      t.integer :estimate
      t.integer :priority
      t.string :status

      t.timestamps
    end
  end
end
