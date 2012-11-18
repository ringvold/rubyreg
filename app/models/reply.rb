class Reply < ActiveRecord::Base
  belongs_to :event
  has_many :field_replies

  accepts_nested_attributes_for :field_replies, :allow_destroy => true
  attr_accessible :field_replies_attributes, :event_id
  validates :event, :presence => true
  
  def create_field_replies(reply, field_ids)
  	self.transaction do
  		self.save
	  	reply.each do |key, value|
	  		field_id = field_ids.fetch "hidden_#{key}"
	  		if key.eql? :id
	  		else
	  			field_replies.create(:content => value, :field_id => field_id)
	  		end
	  	end
	  end
  end

end

