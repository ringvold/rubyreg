class Reply < ActiveRecord::Base
  belongs_to :event, :counter_cache => "replies_count"
  has_many :field_replies

  accepts_nested_attributes_for :field_replies, :allow_destroy => true
  attr_accessible :field_replies_attributes, :event_id
  validates :event, :presence => true
  
  def create_field_replies(reply, field_ids)
  	transaction do
  		save
	  	reply.each do |key, value|
	  		field_id = field_ids.fetch "hidden_#{key}".to_sym
	  		if key.eql? :id
	  		else
	  			field_replies.create(:content => value, :field_id => field_id)
	  		end
	  	end
	  end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end

