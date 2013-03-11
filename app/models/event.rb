class Event < ActiveRecord::Base
  belongs_to :event_type
  has_many :replies, :dependent => :destroy
  has_many :field_replies, :through => :replies
  has_many :fields, :dependent => :destroy

  validates :title, :start_date, :end_date, :max_att, :presence => true
  validates :max_att, :numericality => true

  # scope :active, 	where(:active => true)
  scope :active, lambda {
    				where("start_date < ?", Date.today)
    				.where("end_date > ?", Date.today)}
  scope :last, limit(5)

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
        f.instance_eval { attribute "#{field.id}"}
        if field.required
          eval("f.validates '#{field.id}', :presence => true")
        end
        if field.field_type.field_type == "email"
          eval("f.validates '#{field.id}', :format => { :with => /^([-a-z0-9_]+\.?)+\@([-a-z0-9]+\.)+([a-z0-9]{2,4}$)/i }") # /^([-a-z0-9_]+\.?)+\@([-a-z0-9]+\.)+([a-z0-9]{2,4}$)/i
        end
      end
    end
    form_maker.new(params)
  end

  def slug_and_label
    slug_label = {}
    fields.map {|f| slug_label[f.id.to_s] = f.field_label}
    slug_label
  end
end