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

  def paid_or_overdue(bill)
    if bill.paid?
      content_tag :span, class:'small text-success' do
        "- Paid!"
      end
    elsif bill.over_due?
      content_tag :span, class:'small text-danger' do
        "- Over Due!"
      end
    end
  end
end
