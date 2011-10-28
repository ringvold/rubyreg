class EventType < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :fields
end
