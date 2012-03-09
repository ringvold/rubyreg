# encoding: utf-8

require 'spec_helper'

describe "AddFieldTypes" do
	
	before(:each) do
    @field_type = Factory(:field_type)
  end

  it "adds a new field type" do
    visit new_field_type_path()
    fill_in "Navn", :with => "Tekst"
    fill_in "Type", :with => "text"
    click_button "Lagre"
    current_path.should eq(field_types_path(@event))
  end
end
