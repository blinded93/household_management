class RoomItem < ActiveRecord::Base
  include Joins
  include Shared

  validates :stock, :room_id, :item_id, :threshold, presence:true
  validate :stock_threshold_level

  belongs_to :room
  belongs_to :item

  scope :with_requests, -> { where(request: true) }
  scope :need_purchased, -> { where("stock <= threshold") }
  scope :entire_stock, -> { where("stock > threshold") }

  def self.find_or_create(attrs)
    new_ri = RoomItem.new(attrs)
    if room_item = RoomItem.find_by(room_id:new_ri.room_id, item_id:new_ri.item_id)
      room_item.update(attrs)
    else
      new_ri.save
      new_ri
    end
  end

  def item_attributes=(attrs)
    self.item = Item.find_or_create_by(attrs)
  end

  def cols
    [:item_id, :stock, :threshold, :room_id]
  end

  def columns
    ["stock", "threshold"]
  end

  def unique
    if !!RoomItem.find_by(room_id:room_id, item_id:item_id)
      errors.add(:item_id, "is already on that list.")
    end
  end

  def stock_threshold_level
    if stock && threshold && stock < threshold
      errors.add(:stock, "must be greater than Threshold.")
    end
  end
end
