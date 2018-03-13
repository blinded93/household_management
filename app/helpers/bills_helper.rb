module BillsHelper
  def mark_bill_as_paid_btn(bill)
    if bill.is_a?(Bill) && bill.persisted?
      link_to (bill.paid ? "Mark as Unpaid" : "Mark as Paid"),
        pay_household_bill_path(bill),
        class:"btn btn-sm btn-outline-success text-dark ml-2",
        method:'patch',
        remote:true
    end
  end

  def remaining_expenses
    bills = current_household.bills
    number_to_currency(bills.this_month.sum(:amount) + bills.over_due.sum(:amount))
  end
end
