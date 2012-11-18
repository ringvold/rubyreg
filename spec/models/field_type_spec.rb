require 'spec_helper'

describe FieldType do 
  
	it "can not save empty fields" do
    ft = FieldType.new
		
    assert !ft.save
  end
end
