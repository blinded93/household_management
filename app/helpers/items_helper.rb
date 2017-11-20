module ItemsHelper
  def render_edit(item, addee)
    render "#{addee.class_name}_items/edit", item:item, "#{addee.class_name}_item".to_sym => item.addee_item(addee)
  end

  def item_edit_link(item, addee)
    link_to item.name,
        [item.addee_item(addee)],
        data:{toggle:'modal',
              target:"#edit_item_#{item.id}"},
        class:'btn btn-sm text-info'
  end

  def item_name(item, addee)
    if addee.is_a?(List)
      admin? ? item.name : item_edit_link(item, addee)
    elsif addee.is_a?(Room)
      admin? ? item_edit_link(item, addee) : item.name
    end
  end
end
