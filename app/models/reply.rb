class Reply < ActiveRecord::Base
  belongs_to :event
  belongs_to :field_reply
end
