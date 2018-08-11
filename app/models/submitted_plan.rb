class SubmittedPlan < ActiveRecord::Base
  has_many :submitted_plandetails
  accepts_nested_attributes_for :submitted_plandetails, :allow_destroy => true
end
