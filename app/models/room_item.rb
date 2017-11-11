class RoomItem < ActiveRecord::Base
  belongs_to :room
  belongs_to :item

  def self.find_or_create(attrs, item)
    search_attrs = attrs.select{|key, value| key != 'stock' && !value.is_a?(Hash)}
    search_attrs[:item_id] = item.id
    if room_item = RoomItem.find_by(search_attrs)
      room_item.quantity += attrs[:stock].to_i
    else
      room_item = RoomItem.new(attrs)
    end
    room_item.save
    room_item
  end

  def item_attributes(attrs)
    if item = Item.find_by(attrs)
      self.item = item
    else
      self.create_item(attrs)
    end
    self.save
  end
end
