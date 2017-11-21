module ChoresHelper
  def strikeout(chore)
    'strikeout' if chore.completed
  end
end
