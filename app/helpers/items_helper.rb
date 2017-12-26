module ItemsHelper
  def render_edit(item, addee)
    render "#{addee.class_name}_items/edit", item:item, "#{addee.class_name}_item".to_sym => item.addee_item(addee)
  end

  def item_edit_link(item, addee)
    ai = item.addee_item(addee)
    link_to item.name,
      [ai],
      data:{toggle:'modal',
            target:"#edit_#{ai.class_name}_#{ai.id}"},
      class:"btn btn-sm text-info"
  end

  def remove_button(item, addee)
    link_to "&times;".html_safe,
      [item.addee_item(addee)],
      class:'btn btn-sm text-muted close',
      method:'delete',
      data:{confirm:'Remove Item?'}
  end

  def inventory_request(item, addee)
    link_to item.name,
      [item.addee_item(addee), :request, tab:'inventory'],
      class:'btn btn-sm text-info',
      method:'post',
      data:{confirm:'Request Item?'}
  end

  def item_name(item, addee)
    if addee.is_a?(List)
      admin? ? item.name : item_edit_link(item, addee)
    elsif addee.is_a?(Room)
      admin? ? item_edit_link(item, addee) : inventory_request(item, addee)
    end
  end
end
