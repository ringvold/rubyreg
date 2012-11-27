class AddConfirmationMessageToEvent < ActiveRecord::Migration
  def change
    add_column :events, :confirmation_message, :text

  end
end
