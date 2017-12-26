module RoomItemsHelper
  def restock_count(room_items)
    room_items.need_purchased.count + room_items.with_requests.count
  end

  def request_border(item, addee)
    if item.addee_item(addee).try(:request)
      'border border-danger'
    end
  end
end
