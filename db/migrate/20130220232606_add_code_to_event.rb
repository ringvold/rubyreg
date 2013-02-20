class AddCodeToEvent < ActiveRecord::Migration
  def up
    add_column :events, :code, :string

    Event.all.each do |event|
  		code = SecureRandom.urlsafe_base64(8)
    	begin
    		puts "Code for event #{event.id}: #{code}"
        event.code = code
      end while Event.find_by_code(code)
      event.save
    end
  end

  def down
    remove_column :events, :code
  end
end
