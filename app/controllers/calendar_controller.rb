class CalendarController < ApplicationController
  helper_method :menu_partial
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @bills = current_household.bills.group_by(&:due_date)
  end
end
