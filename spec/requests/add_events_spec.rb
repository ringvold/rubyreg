require 'spec_helper'

describe "AddEvents" do

  it "adds a new event" do
    visit new_event_path
    fill_in "Title", :with => "Test"
    fill_in "Start date", :with => "25.10.2011"
    fill_in "End date", :with => "25.11.2011"
    fill_in "Max att", :with => "25"
    click_button "Create Event"
    current_path.should eq(edit_event_path(1))
  end
end

