

# The html for the calendar is constructed server side combining logic with content_tags

class CalendarGenerator
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  include ActionView::Helpers::UrlHelper

  attr_reader :header, :date, :events_data_file, :events

  def initialize(date, events_data_file="events_data.json")
    @date = date
    @header = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    @events = CalendarEvent.load_events(events_data_file)
  end

  def generate
    content_tag(:table, nil, class: "table table-bordered table-striped") do
      content_tag(:thead, generate_header).concat(generate_days) 
    end.html_safe
  end

  def generate_header
    content_tag :tr do
      @header.map {|day| content_tag(:th, day)}.join.html_safe
    end
  end

  def generate_days
    content_tag(:tbody, week_rows).html_safe
  end 

  private
  def week_rows
    weeks.map do |week|
      content_tag :tr do
        week.collect {|entry| day_cell(entry) }.join.html_safe
      end
    end.join.html_safe
  end

  #appropriate classes are attached to format the day cells
  def day_cell(cell_date)
    attach_class = (cell_date.month != @date.month ? "outlier-days" : "")
    cell_content = day_cell_content(cell_date)
    attach_class += " info" if cell_content.include?("href")
    attach_class += " day-cells"
    content_tag(:td, cell_content, class: attach_class)
  end

  def day_cell_content(cell_date)
    content_tag(:div) do
      main_content = content_tag(:span, cell_date.day).html_safe
      main_content += attach_event(cell_date)
    end.html_safe
  end

  def attach_event(date)
    date_key = date.to_s
    event_links = []
    if @events.key?(date_key)
      if @events[date_key].size > 2

        event_links << build_multiple_events_link(@events[date_key])
      else
        @events[date_key].each do |event|
          event_links << content_tag(:p, link_to(event["occasion"], "#", class: "event_link", "data-invited" => event["invited_count"])).html_safe
        end
      end
    end
    event_links.join.html_safe
  end

  #more than 2 events for a given day is displayed as a single link
  def build_multiple_events_link(events)
    event_names = []
    event_invites = []
    events.each do |event|
      event_names << event["occasion"]
      event_invites << event["invited_count"]
    end
    content_tag(:p, link_to("#{events.size} events", "#", class: "more_events_link", "data-event-names" => event_names.join(","), "data-event-invites" => event_invites.join(","))).html_safe
  end

  #gets the days for the month and splits them into groups of 7 for the weeks
  def weeks
    start_date = @date.beginning_of_month.beginning_of_week(:sunday)
    end_date = @date.end_of_month.end_of_week(:sunday)
    dates_in_month = (start_date..end_date).to_a
    dates_in_month.each_slice(7).to_a
  end
end