module ApplicationHelper
  def remove_btn(scope, obj)
    link_to "&times;".html_safe,
      [scope, obj],
      class:'btn btn-sm text-muted close',
      method:'delete',
      remote:true,
      data:{confirm:"<div class='text-center h5 pt-3'>Delete #{obj.class_name}?</div>"}
  end

  def refresh_btn(object_type)
    link_to("Refresh",
      [current_household, object_type, :reload],
      remote:true,
      class:btn).html_safe
  end

  def link
    'btn btn-sm text-info ml-2'
  end

  def btn
    'btn btn-sm btn-outline-secondary text-dark ml-2'
  end

  def btn_delete
    'btn btn-sm btn-outline-secondary text-danger'
  end

  def errors
    'text-danger small mr-auto'
  end

  def dialog_form_path(obj)
    case obj
    when ListItem
      [current_member, obj]
    when Household
      [obj]
    else
      [current_household, obj]
    end
  end

  def dialog_submit_btn(f)
    obj = f.object
    f.submit((obj.new_record? ? "Create" : "Update"),
      class:btn,
      form:( obj.new_record? ? "new_#{obj.class_name}" : "edit_#{obj.row_id}" )
    ).html_safe
  end

  def form_render(f)
    render "#{f.object.plural_name}/form", f:f
  end

  def form_header(obj)
    content_for :header do
      if item?(obj)
        obj.new_record? ? "Add Item" : "Edit #{obj.item.name}"
      else
        obj.new_record? ? "Create #{obj.class}" : "Edit #{obj.class}"
      end
    end
  end

  def form_error_div(obj)
    content_tag :div,
      id:obj.error_div_id,
      class:errors do
    end
  end
end
