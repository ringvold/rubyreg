class CreateFields < ActiveRecord::Migration
  def self.up
    create_table :fields do |t|
      t.string :field_label, :null => false
      t.string :field_order, :null => false
      t.string :description
      t.boolean :required,  :null => false
      t.integer :event_id, :null => false
      t.integer :field_type_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :fields
  end
end

