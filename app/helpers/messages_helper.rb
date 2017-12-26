module MessagesHelper
  def action(id)
    if action_name == "create"
      "new_message_"
    else
      "reply_message_#{id}_"
    end
  end

  def field_id(field, id=nil)
    [action(id), field.to_s].join.html_safe
  end

  def message_errors(id)
    [action(id), "errors"].join.html_safe
  end

end
