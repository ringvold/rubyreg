class Field < ActiveRecord::Base
  belongs_to :field_type
  belongs_to :event
  
 	attr_accessible :slug, :field_label, :event_id, :field_type_id, :field_order, :required
  
  validates :field_label, :event_id, :field_type_id, :presence => true
 	
 	# act_as_url :field_label, :url_attribute => :slug

	def self.update_order(data)
		Field.update(data.keys, data.values)
	end

end