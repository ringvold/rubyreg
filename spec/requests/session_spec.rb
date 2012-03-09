require 'spec_helper'

describe "Session" do

	before(:each) do
  	@user = Factory(:user)
	end

	it "logs in a user" do
		visit login_url
		fill_in "Brukernavn", :with => @user.username	
		fill_in "Passord", :with => "test"
		click_button "Logg inn"
		current_path.should eq dashboard_path()
	end

	it "logs out a user" do
		visit logout_url
		current_path.should eq login_path()
		page.has_content? "Avlogget!"
	end

	it "fails to log in a user" do
		visit login_url
		fill_in "Brukernavn", :with => @user.username	
		fill_in "Passord", :with => "feilpassord"
		click_button "Logg inn"
		current_path.should eq sessions_path()
		page.has_content? "Feil brukernavn eller passord"
	end

end