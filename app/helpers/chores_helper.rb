module ChoresHelper
  def strikeout(chore)
    'strike-through' if chore.completed
  end

  def chores_hash(scope, scope_title, chores)
    hash = {scope:scope, scope_title:scope_title, chores:[]}
    chores.empty? ? hash : hash.merge({chores:chores})
  end
end
