module CalendarHelper
  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  def display_chore(chores, date)
    if chores[date]
      "Chores(#{chores[date].count})"
    end
  end

  def display_bills(bills, date)
    if bills[date]
      "Bills(#{bills[date].count})"
    end
  end
end
