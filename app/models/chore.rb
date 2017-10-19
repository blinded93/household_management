class Chore < ActiveRecord::Base
  belongs_to :member

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
      due_today: "Due Today",
      due_tomorrow: "Due Tomorrow",
      future: "Future",
      completed: "Completed"
    }
  end

  # def self.chores_from_ids(member)
  #   params.collect {|id| member.chores.find_by(id: id)}
  # end

  def formatted_due_date
    due_date.strftime("%D")
  end

  def after_today
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past.")
    end
  end
end
