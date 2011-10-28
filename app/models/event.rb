class Event < ActiveRecord::Base
  validates :title, :start_date, :end_date, :max_att, :presence => true
  validates :max_att, :numericality => true

  has_many :replies
  has_many :field_replies, :through => :replies
  has_many :fields

  scope :active, lambda { where("events.active = ? ") }

#  def to_slug
#    title.downcase.gsub(' ', '-')
#  end

end

