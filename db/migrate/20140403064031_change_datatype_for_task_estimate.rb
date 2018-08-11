class ChangeDatatypeForTaskEstimate < ActiveRecord::Migration
  def self.up
    change_column :tasks, :estimate, :decimal
  end

  def self.down
    change_column :tasks, :estimate, :integer
  end
end
