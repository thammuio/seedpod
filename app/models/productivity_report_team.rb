class ProductivityReportTeam < ActiveRecord::Base
  belongs_to :productivity_report
  belongs_to :team

  before_create :pending
  before_create :is_resent_zero

  def pending
    self.status = "Pending"
  end
  def is_resent_zero
    self.is_resent = 0
  end
end