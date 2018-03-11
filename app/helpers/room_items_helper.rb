module RoomItemsHelper
  def restock_count(room_items)
    room_items.need_purchased.count + room_items.with_requests.count
  end

  def requested?(room_item)
    if room_item.request
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
      method:'patch',
      remote:true).gsub("\"", "'").html_safe
  end

  def inventory_request(item, addee)
    room_item = item.addee_item(addee)
    link_to(item.name,
        [ current_member,
          room_item,
          :request,
          a:(room_item.request ? "undo" : "request") ],
        class:'btn btn-sm text-info',
        method:'patch',
        remote:true,
        data:{confirm:inventory_confirmation(item, addee)}).gsub("\"", "'").html_safe
  end

  def inventory_confirmation(item, addee)
    body = item.addee_item(addee).request ? "Undo Item Request?" : "Request Item?"
    "<div class='text-center h5 pt-3'>#{body}</div>"
  end

  def room_item_edit_link(item, addee)
    room_item = item.addee_item(addee)
    link_to(item.name,
        edit_household_room_item_path(current_household, room_item),
        remote:true,
        class:'btn btn-sm text-info').html_safe
  end
end
