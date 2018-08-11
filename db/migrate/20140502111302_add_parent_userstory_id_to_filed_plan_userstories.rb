class AddParentUserstoryIdToFiledPlanUserstories < ActiveRecord::Migration
  def change
    add_column :filed_plan_userstories, :parent_userstory_id, :integer
  end
end
