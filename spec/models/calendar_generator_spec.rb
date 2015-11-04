require "rails_helper"

describe CalendarGenerator do

  before :example do
    @date = "2015-03-14".to_date
    @calendar = CalendarGenerator.new(@date, "spec/events_data_test.json")
  end

  context "Generate header" do
    it "should generate the names of days of the week" do
      html_string = @calendar.generate_header
      expect(html_string).to start_with("<tr>")
      expect(html_string).to end_with("</tr>")
      expect(html_string).to include("<th>Sunday</th>")
    end
  end

  context "Generate days" do
    it "should generate calendar days for the given month" do
      html_string = @calendar.generate_days
      expect(html_string).to match(/(3[01]|[12][0-9]|[1-9])/)
    end
  end

  context "#attach_event" do
    it "should attach event info if present" do
      html_string = @calendar.send(:attach_event, "2015-04-24".to_date)
      expect(html_string).to include("event_link")
    end

    it "should attach a 'more_events_link' when a date has more than 2 events" do
      html_string = @calendar.send(:attach_event, @date)
      expect(html_string).to include("more_events_link")
    end

    it "should include the event names and event invites count in the 'more_events_link'" do
      html_string = @calendar.send(:attach_event, @date)
      expect(html_string).to include("data-event-names")
      expect(html_string).to include("data-event-invites")
    end
  end

  context "Weeks" do
    it "should get the entire month in groups of seven, given a date" do
      weeks = @calendar.send(:weeks)
      expect(weeks.sample.size).to eq(7)
    end
  end

end