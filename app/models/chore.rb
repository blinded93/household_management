class Chore < ActiveRecord::Base
  belongs_to :member

  scope :due_today, -> { where(due_date: Date.today) }
  scope :due_tomorrow, -> { where(due_date: Date.tomorrow) }
  scope :belonging_to, -> (member) { where(member_id: member.id) }

  def formatted_due_date
    due_date.strftime("%D")
  end
end
