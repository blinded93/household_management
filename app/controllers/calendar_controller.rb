class CalendarController < ApplicationController
  def day
    set_events_and_date
    respond_to do |format|
      format.js
    end
  end

  def load
    set_events_and_date
    respond_to do |format|
      format.js
    end
  end

  private
  def set_events_and_date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @bills = current_household.bills.group_by(&:due_date)
    @chores = Chore.for(current_household)
    @chores_by_date = @chores.group_by(&:due_date)
    @events = @bills.merge(@chores_by_date)
  end
end
