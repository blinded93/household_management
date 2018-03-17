class RoomItem < ActiveRecord::Base
  include Joins
  include Shared

  validates :stock, :room_id, :item_id, :threshold, presence:true
  validate :positive_stock, :positive_threshold
  validate :unique?

  belongs_to :room
  belongs_to :item

  scope :with_requests, -> { where(request: true) }
  scope :need_purchased, -> { where("stock <= threshold") }

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

  def positive_stock
    if stock && stock < 0
      errors.add(:stock, "cannot be negative.")
    end
  end

  def positive_threshold
    if threshold && threshold < 0
      errors.add(:threshold, "cannot be negative.")
    end
  end

  def scopes
    {room.name.downcase.tr(" ", "_").to_sym => room.name}
  end
end
