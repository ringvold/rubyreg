require 'harar/naming'
class ReplyForm
	include ActiveAttr::Model


	attr_accessor :name

	def persisted?
		false
	end

end