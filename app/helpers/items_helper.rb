module ItemsHelper
  def render_edit(item, addee)
    render "#{addee.class_name}_items/edit",
            item:item,
           "#{addee.class_name}_item".to_sym => item.addee_item(addee)
  end

  def room_item_edit_link(item, addee)
    room_item = item.addee_item(addee)
    link_to(item.name,
        edit_household_room_item_path(current_household, room_item),
        remote:true,
        class:'btn btn-sm text-info').html_safe
  end

  def list_item_edit_link(item, addee)
    list_item = item.addee_item(addee)
    link_to(item.name,
        edit_member_list_item_path(current_member, list_item),
        remote:true,
        class:'btn btn-sm text-info').html_safe
  end

  def item_remove_btn(item, addee)
    unless !admin? && addee.is_a?(Room)
      link_to("&times;".html_safe,
          [current_household, item.addee_item(addee)],
          class:'btn btn-sm text-muted close',
          method:'delete',
          remote:true,
          data:{confirm:'Remove Item?'}).html_safe
    end
  end

  def inventory_request(item, addee)
    link_to(item.name,
        [
          current_member,
          item.addee_item(addee),
          :request,
          a:'request'
        ],
        class:'btn btn-sm text-info',
        method:'post',
        remote:true,
        data:{confirm:'Request Item?'}).html_safe
  end

  def item_name(item, addee)
    if addee.is_a?(List)
      admin? ? item.name : list_item_edit_link(item, addee)
    elsif addee.is_a?(Room)
      admin? ? room_item_edit_link(item, addee) : inventory_request(item, addee)
    end
  end

  def item?(obj)
    obj.class_name.include?("_item")
  end
end
