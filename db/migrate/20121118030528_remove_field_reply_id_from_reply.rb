class RemoveFieldReplyIdFromReply < ActiveRecord::Migration
  def up
  	remove_column :replies, :field_reply_id
  end

  def down
  	add_column :replies, :field_reply_id, :integer
  end
end
