module BillsHelper
  def bill_sum(date)
    current_household.bills.due_on(date).sum(:amount)
  end

  def scope_bill_sum(bills, scope)
    number_to_currency(bills.send(scope).sum(:amount))
  end
end
