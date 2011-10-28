require 'spec_helper'

describe Event do

  it "can not save empty fields title, start_date, end_date and max_att" do
    event = Event.new

    assert !event.save
  end

  it "can add field" do
    event = Event.create({:title => "test", :start_date => "12.12.2011", :end_date => "12.12.2012", :max_att => 30})
    field_type = FieldType.create({:title => "Email", :field_type => "EmailAdress"})
    event.fields.create({:field_label => "Email" ,:field_order => "1",  :required => true, :event_id => event.id, :field_type_id => field_type.id})
    
    assert !event.fields.empty?
  end
end