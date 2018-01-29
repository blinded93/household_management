module ApplicationHelper
  def remove_btn(scope, obj)
    link_to "&times;".html_safe,
      [scope, obj],
      class:'btn btn-sm text-muted close',
      method:'delete',
      remote:true,
      data:{confirm:"Delete #{obj.class_name}?"}
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

  def dialog_form(obj)
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
            )
  end

  def objects_hash(scope, scope_title, objects)
    {
      scope:scope,
      scope_title:scope_title,
      objects.first.plural_name.to_sym => objects
    }
  end
end
