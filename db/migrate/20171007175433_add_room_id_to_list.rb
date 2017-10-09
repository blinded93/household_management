class AddRoomIdToList < ActiveRecord::Migration
  def change
    add_column :lists, :room_id, :integer
  end
end
