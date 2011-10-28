class FieldReply < ActiveRecord::Base
  
  has_many :replies
  has_many :events
end
