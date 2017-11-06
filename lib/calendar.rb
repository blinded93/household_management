class Calendar < Struct.new(:view, :date, :callback)
  HEADER = %w[Sun Mon Tue Wed Thu Fri Sat]
  START_DAY = :sunday

  delegate :content_tag, to: :view

  def table
    content_tag :table, class: "calendar table table-bordered" do
      header + week_rows
    end
  end

  def header
    content_tag :tr, class:'bg-info' do
      HEADER.map { |day| content_tag :th, day, class:'text-center p-1' }.join.html_safe
    end
  end

  def week_rows
    weeks.map do |week|
      content_tag :tr, class:'bg-secondary' do
        week.map { |day| day_cell(day) }.join.html_safe
      end
    end.join.html_safe
  end

  def day_cell(day)
    content_tag :td, view.capture(day, &callback), class: day_classes(day)
  end

  def day_classes(day)
    classes = []
    classes << "day-cell"
    classes << "table-success" if day == Date.today
    classes << "table-active" if day.month != date.month
    classes.empty? ? nil : classes.join(" ")
  end

  def weeks
    first = date.beginning_of_month.beginning_of_week(START_DAY)
    last = date.end_of_month.end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end
end
