# encoding: utf-8

require 'spec_helper'

describe "AddFields" do
	
	before(:each) do
    @event = Factory(:event)
    @field_type = Factory(:field_type)
  end

  it "adds a new field" do
    pending "capybara cannot find option or element"
    visit new_event_field_path(@event)
    fill_in "Tittel", :with => "Test"
    check 	"Må utfylles"
    select  "Tekst", :from => "Type"
    click_button "Lagre"
    current_path.should eq(edit_event_path(@event))
  end
end
