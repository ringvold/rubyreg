class PublicController < ApplicationController
	
	def index
		@events = Event.all
		@reply = Reply.new
	end
	
end
