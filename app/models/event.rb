class Event < ActiveRecord::Base
  validates :title, :start_date, :end_date, :max_att, :presence => true
  validates :max_att, :numericality => true

  has_many :replies
  has_many :field_replies, :through => :replies
  has_many :fields

  scope :active, 	where(:active => true)
  scope :active_and_active_by_date, 
  				active.where("start_date < ?", Date.today)
  				.where("end_date > ?", Date.today)
  
#  def to_slug
#    title.downcase.gsub(' ', '-')
#  end

end