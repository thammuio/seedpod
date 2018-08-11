class AddSlugToFiledPlanUserstories < ActiveRecord::Migration
  def change
    add_column :filed_plan_userstories, :slug, :string
  end
end
