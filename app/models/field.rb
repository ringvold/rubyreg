class Field < ActiveRecord::Base
  validates :field_label, :event_id, :field_type_id, :presence => true
 	attr_accessible :field_label, :event_id, :field_type_id, :field_order, :required
  
  has_one :field_type
  has_one :event

	def self.update_order(data)
		Field.update(data.keys, data.values)
	end

end

