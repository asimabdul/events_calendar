
class CalendarController < ApplicationController
  def index
    @date = params.fetch(:date, Date.today).to_date
    @calendar = CalendarGenerator.new(@date).generate
    @calendar_events = CalendarEvent.load_events
  end
end