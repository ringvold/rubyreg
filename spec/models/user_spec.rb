require 'spec_helper'

describe User do
	before(:each) do
    @user = Factory(:user)
  end
  
	it "can not have empty fields" do
		user = User.new

		assert !user.save
	end

	it "can add and save user" do
		assert @user
	end

	it "can delete user" do
		@user.destroy
		assert !@user.save
	end
end