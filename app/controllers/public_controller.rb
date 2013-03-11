class PublicController < ApplicationController

	def index
		@events = Event.active
		@reply = Reply.new
	end

end
