module RoomItemsHelper
  def restock_count(room_items)
    room_items.need_purchased.count + room_items.with_requests.count
  end
end
