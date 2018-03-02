class Bill < ActiveRecord::Base
  include Shared

  belongs_to :household

  validates :company, :utility, :amount, :due_date, presence: true

  default_scope { order(due_date: :asc) }
  scope :paid, -> { where(paid:true) }
  scope :unpaid, -> { where(paid:false) }
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
      next_month: "Next Month",
      paid: "Paid"
    }
  end

  def cols
    [:company, :utility, :amount, :account_number, :due_date]
  end

  def scopes
    Bill.scopes.select do |scope, scope_title|
      Bill.send(scope).pluck(:id).include?(self.id)
    end
  end
end
