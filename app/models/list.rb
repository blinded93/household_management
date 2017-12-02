class List < ActiveRecord::Base
  include Shared

  belongs_to :member
  has_many :list_items
  has_many :items, through: :list_items
  scope :for, -> (household) {
    joins(:member).
    where(members: {household_id: household.id})
  }

  def size
    items.count
  end
end
