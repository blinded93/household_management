module BillsHelper
  def bill_sum(date)
    current_household.bills.due_on(date).sum(:amount)
  end
end
