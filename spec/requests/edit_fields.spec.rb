# encoding: utf-8

require 'spec_helper'

describe "EditFields" do

	before(:each) do
		@event = Factory(:event)
  	@field = Factory(:field)
  	@field_type = Factory(:field_type)
	end
	
	it "can edit fields" do
		visit edit_event_field_path(@field,@event)
		fill_in "Tittel", :with => "Navn"
    check 	"Må utfylles"
    select  "Tekst", :from => "Type"
		current_path.should eq field_types_path()
	end
end