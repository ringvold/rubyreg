require 'harar/naming'
class ReplyForm
	include ActiveAttr::Model
	extend Harar::Naming

	def persisted?
		false
	end

end