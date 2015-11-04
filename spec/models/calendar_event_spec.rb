require "rails_helper"

describe CalendarEvent do

  subject {CalendarEvent.load_events("spec/events_data_test.json")}

  context "#load_events" do
    it "should read the entries from the data file and load the records into a hash" do
      expect(subject).to be_an_instance_of(Hash)
    end

    it "should group the events by date" do
      expect(subject.keys.sample.to_date).to be_an_instance_of(Date)
    end

    it "should put the events info as values in the hash" do
      events = subject
      values = events[events.keys.sample]
      expect(values.sample.keys).to match_array(["occasion", "invited_count"])
    end

  end

end