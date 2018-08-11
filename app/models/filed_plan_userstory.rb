class FiledPlanUserstory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :filed_plan_detail
  before_save :set_userstory_slug
end