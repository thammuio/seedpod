class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
    add_index :teams, :user_id
  end
end
