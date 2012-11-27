class EventType < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :events
end
