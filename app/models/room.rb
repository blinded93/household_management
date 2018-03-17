class Room < ActiveRecord::Base
  include Shared

  validates :name, presence: true

  belongs_to :household
  belongs_to :member
  has_many :room_items, dependent: :destroy
  has_many :items, through: :room_items

  scope :unowned, -> { where(member_id: nil) }
  scope :owned, -> { where("member_id IS NOT NULL") }

  def cols
    [:name]
  end

  def size
    items.count
  end

  def scope
    name.downcase.tr(" ", "_")
  end
end
