class Field < ActiveRecord::Base
  belongs_to :field_type
  belongs_to :event
  
 	attr_accessible :slug, :field_label, :event_id, :field_type_id, :field_order, :required
  
  validates :field_label, :event_id, :field_type_id, :presence => true
 	validate :field_label_cannot_have_value_test

 	acts_as_url :field_label, :url_attribute => :slug

	def self.update_order(data)
		Field.update(data.keys, data.values)
	end

	def field_label_cannot_have_value_test
    if field_label == "test"
      errors.add(:field_label, "kan ikke ha verdien 'test'")
    end
  end

end