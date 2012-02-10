require 'spec_helper'

describe Field do

  it "can not save empty fields" do
    field = Field.new

    assert !field.save
  end


end