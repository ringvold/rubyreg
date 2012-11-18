class CreateFieldReplies < ActiveRecord::Migration
  def self.up
    create_table :field_replies do |t|
      t.integer :field_id
      t.integer :reply_id
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :field_replies
  end
end
