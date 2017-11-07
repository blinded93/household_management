module BillsHelper
  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  def bill_sum(date)
    current_household.bills.due_on(date).sum(:amount)
  end
end
