class DashboardController < ApplicationController
	before_filter :require_login
	def index
		@last_replies = Reply.last
		@last_events = Event.last
	end

end