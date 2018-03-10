module ItemsHelper
  def render_edit(item, addee)
    render "#{addee.class_name}_items/edit",
            item:item,
           "#{addee.class_name}_item".to_sym => item.addee_item(addee)
  end

  def item_remove_btn(item, addee)
    unless !admin? && addee.is_a?(Room)
      link_to("&times;".html_safe,
          [current_household, item.addee_item(addee)],
          class:'btn btn-sm text-muted close',
          method:'delete',
          remote:true,
          data:{confirm:"<div class='text-center h5 pt-3'>Remove Item?</div>"}).html_safe
    end
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

  def item_form(f)
    if item?(f.object) && f.object.new_record?
      render 'items/form', f:f
    end
  end
end
