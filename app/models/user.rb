class User < ActiveRecord::Base

	attr_accessible :email, :password, :password_confirmation, :role, :name

	authenticates_with_sorcery!
	validates :name, :email, :role, :presence => true
	validates :password, :presence => true, :on => :create
	# validates :username, :uniqueness => true
	validates_confirmation_of :password, :message => "should match confirmation", :if => :password

end