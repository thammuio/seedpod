class AddUserstorySlugToFiledPlanUserstories < ActiveRecord::Migration
  def change
    add_column :filed_plan_userstories, :userstory_slug, :string
  end
end
