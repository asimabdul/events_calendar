class CalendarEvent
  
  def self.load_events(filename="events_data.json")
    #event loading is memoized
    @events ||= self.parse_json(filename)
  end

  private

  #events are grouped by date. Date is key and values are array of events
  def self.parse_json(filename)
    file_contents = File.read(filename)
    events = Oj.load(file_contents).fetch("events", [])
    events.inject(Hash.new { |h, k| h[k] = [] }) do |acc, event|
      date_key = (event["year"].to_s + "-" + event["month"].to_s + "-" + event["day"].to_s).to_date.to_s
      acc[date_key] << event.slice("occasion", "invited_count")
      acc
    end
  end

end

