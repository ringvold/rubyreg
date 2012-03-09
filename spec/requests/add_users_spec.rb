require 'spec_helper'

describe "AddUser" do

	it "creates a new user" do
		pending "Capybara cannot find element"
		visit new_user_path
		fill_in "Name", :with => "Harald Ringvold"
		fill_in "Username", :with => "harald"
		fill_in "Email", :with => "harald@mjf.nu"
		fill_in "Password", :with => "testlol"
		fill_in "Password confirmation", :with => "testlol"
		fill_in "Role", :with => "admin"
		click_button "Create User"
		current_path.should eq users_path()
	end
end