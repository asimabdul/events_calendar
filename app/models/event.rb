class CalendarEvent
  
  def self.load_events
    @events ||= self.parse_json
  end

  def self.parse_json
    file_contents = File.read("events_data.json")
    Oj.load(file_contents)
  end

end