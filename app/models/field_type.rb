class FieldType < ActiveRecord::Base
  validates :title, :field_type, :presence => true

end
