class PublicController < ApplicationController
	
	def index
		@events = Event.all
	end
	
end
