class Chore < ActiveRecord::Base
  belongs_to :member

  scope :over_due, -> { where("due_date < ?", Date.today) }
  scope :due_today, -> { where(due_date: Date.today) }
  scope :due_tomorrow, -> { where(due_date: Date.tomorrow) }
  scope :not_due, -> { where("due_date > ?", Date.tomorrow) }
  scope :completed, -> { where(completed: true) }
  scope :for, -> (member) { where(member: member) }

  def self.scopes
    {
      over_due: "Over Due",
      due_today: "Due Today",
      due_tomorrow: "Due Tomorrow",
      not_due: "Not Due",
      completed: "Completed"
    }
  end

  def formatted_due_date
    due_date.strftime("%D")
  end
end
