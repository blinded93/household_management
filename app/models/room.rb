class Room < ActiveRecord::Base
  include Shared

  belongs_to :household
  belongs_to :member
  has_many :room_items
  has_many :items, through: :room_items

  scope :unowned, -> { where(member_id: nil) }
  scope :owned, -> { where("member_id IS NOT NULL") }

  def size
    items.count
  end

  def member?
    !!member
  end
  
  def owned_name
    member? ? "#{member.plural} #{name}": name
  end
end
