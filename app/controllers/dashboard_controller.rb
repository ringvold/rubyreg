class DashboardController < ApplicationController
	before_filter :require_login
	def index
		@last_replies = Reply.order('created_at DESC').limit(5)
		@last_events = Event.order('created_at DESC').limit(5)
	end

end