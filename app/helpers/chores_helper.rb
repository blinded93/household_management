module ChoresHelper
  def strikeout(chore)
    'strike-through' if chore.completed
  end

  def badge_color(scope)
    str = "badge"
    case scope
    when :over_due
      str + " badge-danger"
    when :due_today
      str + " badge-warning"
    else
      str + " badge-success"
    end
  end
end
