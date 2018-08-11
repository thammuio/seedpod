class DropFiledUserstoriesTable < ActiveRecord::Migration
  def up
    drop_table :filed_userstories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end