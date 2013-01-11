class AddForeginKeyIndexes < ActiveRecord::Migration
  def up
  	add_index :fields, :event_id
  	add_index :fields, :field_type_id

  	add_index :field_replies, :field_id
  	add_index :field_replies, :reply_id

  	add_index :replies, :event_id
  end

  def down
  	remove_index :fields, :column => :event_id
  	remove_index :fields, :column => :field_type_id

  	remove_index :field_replies, :column => :field_id
  	remove_index :field_replies, :column => :reply_id

  	remove_index :replies, :column => :event_id
  end
end
