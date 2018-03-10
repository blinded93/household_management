module ListItemsHelper
  def list_item_edit_link(item, addee)
    list_item = item.addee_item(addee)
    link_to(item.name,
        edit_member_list_item_path(current_member, list_item),
        remote:true,
        class:'btn btn-sm text-info').html_safe
  end
end
