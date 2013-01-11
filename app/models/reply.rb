class Reply < ActiveRecord::Base
  belongs_to :event, :counter_cache => "replies_count"
  has_many :field_replies, :dependent => :destroy

  accepts_nested_attributes_for :field_replies, :allow_destroy => true
  attr_accessible :field_replies_attributes, :event_id
  validates :event, :presence => true

  scope :last, limit(5)

  def create_field_replies(reply, field_ids)
    transaction do
      save
      reply.each do |key, value|
        if key.eql? :id
        else
          field_replies.create(:content => value, :field_id => key)
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

  def field_replies_all
    Struct.new("FieldReply", :content)
    fr_all = []
    field_replies = self.field_replies
    event.fields_by_order.each do |f|
      size = fr_all.count
      field_replies.each do |fr|
        if fr.field_id.eql? f.id
          fr_all << fr
          break
        end
      end
      if size.eql? fr_all.count
        fr_all << Struct::FieldReply.new("<em class='muted'>tom<em>".html_safe)
      end
    end
    fr_all
  end
end

