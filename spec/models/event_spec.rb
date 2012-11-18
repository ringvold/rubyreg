require 'spec_helper'

describe Event do
  before(:each) do
    @event = Factory(:event)
  end

  it "can not save empty fields" do
    event = Event.new

    assert !event.save
  end

  it "can add field" do
    field_type = Factory(:field_type)
    @event.fields.create(
      :field_label => "Email",
      :field_order => "1",  
      :required => true, 
      :field_type_id => field_type.id
    )
    
    assert !@event.fields.empty?
  end

  it "can get active and active by date" do
    event = Factory(
      :event, 
      :start_date => Date.new + 1, 
      :end_date => Date.new + 5,
      :active => true
    )
    event.save

    event2 = Factory(
      :event, :start_date => Date.new + 1, 
      :end_date => Date.new + 5,
      :active => true
    )
    event2.save
    
    active = Event.active_and_active_by_date
    active.count.should eq(2)
  end

  it "can get active" do
    event = Factory(
      :event,
      :active => true
    )
    events = Event.active
    events.count.should eq 1
  end
  
end