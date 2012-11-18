class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title, :null => false
      t.string :description
      t.date :start_date, :null => false
      t.date :end_date, :null => false
      t.integer :max_att, :null => false
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end

