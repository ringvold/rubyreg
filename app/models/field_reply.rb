class FieldReply < ActiveRecord::Base
  belongs_to :reply
  belongs_to :event
  
  attr_accessible :content, :field_id, :reply_id

  validates :content, :field_id, :reply_id, :presence => true
end
