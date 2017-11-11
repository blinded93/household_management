class AddRequestToRoomItem < ActiveRecord::Migration
  def change
    add_column :room_items, :request, :boolean
    add_column :room_items, :threshold, :integer
  end
end
