require 'spec_helper'

describe "EditFieldTypes" do

	before(:each) do
  	@field_type = Factory(:field_type)
	end
	
	it "edits field type" do
		visit edit_field_type_path(@user)
		fill_in "Navn", :with => "Tekstboks"
		fill_in "Type", :with => "textarea"
		click_button "Lagre"
		current_path.should eq field_types_path()
	end
end