require 'spec_helper'

describe "Session" do

	before(:each) do
  	@user = Factory(:user)
	end

	it "logs in a user" do
		visit login_url
		fill_in "Username", :with => @user.username	
		fill_in "Password", :with => "test"
		click_button "Log in"
		current_path.should eq dashboard_path()
	end

	it "logs out a user" do
		visit logout_url
		current_path.should eq login_path()
		page.has_content? "Avlogget!"
	end

	it "fails to log in a user" do
		visit login_url
		fill_in "Username", :with => @user.username	
		fill_in "Password", :with => "feilpassord"
		click_button "Log in"
		current_path.should eq session_path()
		page.has_content? "Feil brukernavn eller passord"
	end

end