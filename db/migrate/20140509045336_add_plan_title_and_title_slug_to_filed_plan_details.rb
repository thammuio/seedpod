class AddPlanTitleAndTitleSlugToFiledPlanDetails < ActiveRecord::Migration
  def change
    add_column :filed_plan_details, :plan_title, :string
    add_column :filed_plan_details, :title_slug, :string
  end
end
