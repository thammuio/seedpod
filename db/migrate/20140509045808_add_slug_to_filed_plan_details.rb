class AddSlugToFiledPlanDetails < ActiveRecord::Migration
  def change
    add_column :filed_plan_details, :slug, :string
  end
end
