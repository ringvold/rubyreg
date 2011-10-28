require 'spec_helper'

describe Field do

  it "can not save epmty field field_label, event_id, field_type_id" do
    field = Field.new

    assert !field.save
  end


end