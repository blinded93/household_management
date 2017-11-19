module CalendarHelper
  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  def bill_events(date)
    @events[date].select{|e|e.is_a?(Bill)}
  end

  def chore_events(date)
    @events[date].select{|e|e.is_a?(Chore)}
  end

  def display_event(event)
    if event.respond_to?(:utility)
      content_tag(:div, class:'small bg-danger text-light pl-1 pr-1') do
        event.utility
      end
    elsif event.respond_to?(:task)
      content_tag(:div, class:'small bg-warning pl-1 pr-1') do
        event.task
      end
    end
  end
end
