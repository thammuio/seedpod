class ChangeEstimateIntegerToDecimal < ActiveRecord::Migration
  def self.up
    change_column :userstories, :estimate, :decimal
  end

  def self.down
    change_column :userstories, :estimate, :integer
  end
end
