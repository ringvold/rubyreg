# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create :username => "harald", :email => "harald@ringvold.nu", :role => "admin", :password => "test"
FieldType.all.each { |f|f.delete}
FieldType.create :title => "Tekst", :field_type => "string"
FieldType.create :title => "Checkbox", :field_type => "boolean"
FieldType.create :title => "Tekstområde", :field_type => "textarea"