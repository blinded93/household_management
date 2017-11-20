class RoomItem < ActiveRecord::Base
  include Joins

  belongs_to :room
  belongs_to :item

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

  def columns
    ["stock", "threshold"]
  end
end
