class CalendarController < ApplicationController
  def day
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = current_household.bills.group_by(&:due_date).merge(Chore.for(current_household).group_by(&:due_date))
    respond_to do |format|
      format.js
    end
  end

  def load
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = current_household.bills.group_by(&:due_date).merge(Chore.for(current_household).group_by(&:due_date))
    respond_to do |format|
      format.js
    end
  end
end
