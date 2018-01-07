class CalendarController < ApplicationController
  def load
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = current_household.bills.group_by(&:due_date).merge(Chore.for(current_household).group_by(&:due_date))
    respond_to do |format|
      format.js { render 'calendar/load' }
    end
  end
end
