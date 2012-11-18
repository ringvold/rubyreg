class CreateFieldTypes < ActiveRecord::Migration
  def self.up
    create_table :field_types do |t|
      t.string :title, :null => false
      t.string :field_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :field_types
  end
end
