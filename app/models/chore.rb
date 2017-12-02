class Chore < ActiveRecord::Base
  include Shared

  belongs_to :member

  validates :task, presence: true
  validates :member_id, presence: true
  validates :due_date, presence: true
  validate :after_today, on: :create

  default_scope { order(due_date: :desc) }
  scope :over_due, -> { where("due_date < ?", Date.today) }
  scope :due_today, -> { where(due_date: Date.today) }
  scope :due_tomorrow, -> { where(due_date: Date.today + 1) }
  scope :future, -> { where("due_date > ?", Date.today + 1) }
  scope :completed, -> { where(completed: true) }
  scope :for, -> (household) {
    joins(:member).
    where(members: {household_id: household.id})
  }

  def self.scopes
    {
      over_due: "Over Due",
      due_today: "Today",
      due_tomorrow: "Tomorrow",
      future: "Future",
      completed: "Completed"
    }
  end

  def formatted_due_date
    due_date.strftime("%D")
  end

  def after_today
    if !due_date.blank? && due_date < Date.today
      errors.add(:due_date, "can't be in the past.")
    end
  end
end
