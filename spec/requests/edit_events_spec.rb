require 'spec_helper'

describe 'EditEvents' do

  before(:each) do
    @event = Event.create({:title => "test", :start_date => "12.12.2011", :end_date => "12.12.2012", :max_att => 30})
  end

	it "saves changes to event" do
		if ( current_path != (edit_event_path(@event)) )
			visit edit_event_path(@event)
		end
		fill_in "Title", :with => "Another test"
    fill_in "Start date", :with => "01.01.2011"
    fill_in "End date", :with => "02.02.2011"
    fill_in "Max att", :with => "10"
    click_button "Update Event"
    current_path.should eq(edit_event_path(@event.id))
	end
end