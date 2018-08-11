class RenameColumnFromFiledPlanDetailToFiledPlanDetailId < ActiveRecord::Migration
  def change
    rename_column :filed_plan_userstories, :filed_plan_detail, :filed_plan_detail_id
    add_index :filed_plan_userstories, :filed_plan_detail_id
  end
end
