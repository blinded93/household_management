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

  def chores_hash(scope, scope_title, chores)
    hash = {scope:scope, scope_title:scope_title, chores:[]}
    chores.empty? ? hash : hash.merge({chores:chores})
  end
end
