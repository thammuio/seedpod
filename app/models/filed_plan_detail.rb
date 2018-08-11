class FiledPlanDetail < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :plan_title, use: :slugged

  has_many :filed_plan_userstories
  has_many :filed_plan_tasks
end
