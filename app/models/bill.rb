class Bill < ActiveRecord::Base
  belongs_to :household

  scope :over_due, -> { where("due_date < ?", Date.today) }
  scope :within_week, -> { where(due_date: Date.today..Date.today + 1.week) }
  scope :this_month, -> {
    where(due_date: Date.today.beginning_of_month..Date.today.end_of_month)
    }
  scope :next_month, -> {
    where(due_date: Date.today.next_month.beginning_of_month..Date.today.next_month.end_of_month)
    }
  scope :due_on, -> (date) { where(due_date: date) }

  def self.scopes
    {
      over_due: "Over Due",
      within_week: "Within 7 Days",
      this_month: "This Month",
      next_month: "Next Month"
    }
  end
end
