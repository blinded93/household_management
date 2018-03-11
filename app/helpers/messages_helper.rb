module MessagesHelper
  def action(id)
    if action_name == "create"
      "new_message_"
    else
      "reply_message_#{id}_"
    end
  end

  def new_message?
    !params[:reply_message_id]
  end

  def field_id(field, id=nil)
    [action(id), field.to_s].join.html_safe
  end

  def message_errors(id)
    [action(id), "errors"].join.html_safe
  end

  def members_minus_self
    current_household.members.select {|m| m != current_member}
  end

  def subject_value(message)
    !!message ? "Re:#{message.subject}" : ""
  end
end
