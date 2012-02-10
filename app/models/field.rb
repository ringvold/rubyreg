class Field < ActiveRecord::Base
  validates :field_label, :event_id, :field_type_id, :presence => true

  
  has_one :field_type
  has_one :event
end

