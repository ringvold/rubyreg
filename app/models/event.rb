require 'bureaucrat'
require 'bureaucrat/quickfields'

class Event < ActiveRecord::Base
  has_many :replies
  has_many :field_replies, :through => :replies
  has_many :fields

  validates :title, :start_date, :end_date, :max_att, :presence => true
  validates :max_att, :numericality => true

  scope :active, 	where(:active => true)
  scope :active_and_active_by_date, lambda {
    				active.where("start_date < ?", Date.today)
    				.where("end_date > ?", Date.today)}
  
#  def to_slug
#    title.downcase.gsub(' ', '-')
#  end

	def fields_by_order
		fields.order("field_order ASC")
	end

	def inline_form
    f = Class.new(ReplyForm)
	  yield f
	  f
	end

	def create_form(params = nil)
		form_maker = inline_form do |f|
			fields_by_order.each do |field|
        field_name_symbol = field.field_label.downcase
        new_field = "f.attribute :#{field_name_symbol}"
        new_field_id = "f.attribute :hidden_#{field_name_symbol}, default: #{field.id}"
        eval(new_field)
        eval(new_field_id)
        # f.send(:attr_accessor, "hidden_#{field_name_symbol}")
        # eval("f.hidden_#{field_name_symbol} = field.id")
        if field.required
          eval("f.validates :#{field_name_symbol}, :presence => true")
        end
			end
		end
		form_maker.new(params)
	end
  
end