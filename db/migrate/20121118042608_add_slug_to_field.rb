class AddSlugToField < ActiveRecord::Migration
  def change
    add_column :fields, :slug, :string

  end
end
