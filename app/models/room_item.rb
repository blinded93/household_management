class RoomItem < ActiveRecord::Base
  include Joins
  include Shared

  validates :stock, :room_id, :item_id, :threshold, presence:true
  validate :stock_threshold_level
  validate :unique?

  belongs_to :room
  belongs_to :item

  scope :with_requests, -> { where(request: true) }
  scope :need_purchased, -> { where("stock <= threshold") }
  scope :entire_stock, -> { where("stock > threshold") }
  scope :in, -> (room) { where(room: room) }
  scope :for, -> (household) {
    joins(:room).
    where(rooms: {household_id: household.id})
  }

  def item_attributes=(attrs)
    self.item = Item.find_or_create_by(attrs)
  end

  def cols
    [:item_id, :stock, :threshold, :room_id]
  end

  def columns
    ["stock", "threshold"]
  end

  def unique?
    if !persisted? && RoomItem.find_by(room_id:room_id, item_id:item_id)
      errors.add(:item_id, "is already on that list.")
    end
  end

  def stock_threshold_level
    if !persisted? && stock && threshold && stock < threshold
      errors.add(:stock, "must be greater than Threshold.")
    end
  end

  def scopes
    {room.name.downcase.tr(" ", "_").to_sym => room.name}
  end
end
