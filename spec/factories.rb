Factory.define :event do |f|
  f.sequence(:title) { |n| "Event#{n}" }
  f.start_date "12.12.2011"
  f.end_date	"22.12.2011"
  f.max_att	"30"
  f.active false
end

Factory.define :field_type do |f|
	f.sequence(:title)  { |n| "Field#{n}"}
	f.field_type "text"
end

Factory.define :user do |f|
	f.sequence(:username) { |n| "user#{n}"}
	f.email "user@email.com"
	f.name "User"
	f.password "test"
end

Factory.define :field do |f|
	f.sequence(:field_label) { |n| "Field#{n}"}
	f.description "Test description"
	f.sequence(:field_order) { |n| n }
	f.required true
	f.event_id 1
	f.field_type_id 1
end