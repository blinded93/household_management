module RoomItemsHelper
  def restock_count(room_items)
    room_items.need_purchased.count + room_items.with_requests.count
  end

  def requested?(room_item)
    if room_item.requested?
      "table-danger"
    end
  end

  def request_action
    params[:a] == "request" ? true : false
  end

  def undo_btn
    link_to( 'Undo',
      [current_member, @room_item, :request, a:'undo'],
      class:'btn btn-sm text-danger pt-0',
      method:'post',
      remote:true).gsub("\"", "'").html_safe
  end
end
