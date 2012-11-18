class AddRepliesCountToEvent < ActiveRecord::Migration
  def up
    add_column :events, :replies_count, :integer

   	Event.reset_column_information  
    Event.all.each do |e|  
      Event.reset_counters e.id, :replies
    end  
  end

  def down
  	remove_column :events, :replies_count
  end
end
