  # encoding: utf-8
require 'spec_helper'

describe 'EditEvents' do

  before(:each) do
    @event = Factory(:event)
  end

	it "saves changes to event" do
		visit edit_event_path(@event)
		fill_in "Title", :with => "Another test"
    fill_in "Start date", :with => "01.01.2011"
    fill_in "End date", :with => "02.02.2011"
    fill_in "Max att", :with => "10"
    click_button "Update Event"
    current_path.should eq(edit_event_path(@event))
    page.should have_content("Event was successfully updated.")
	end

  it "adds a new Field", :js => true do
    visit edit_event_path(@event)
    click_on "Nytt felt"
    page.should have_css "#field#{@event.id}"
  end
end