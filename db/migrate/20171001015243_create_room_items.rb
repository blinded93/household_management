class CreateRoomItems < ActiveRecord::Migration
  def change
    create_table :room_items do |t|
      t.integer :stock
      t.references :room, index: true
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :room_items, :rooms
    add_foreign_key :room_items, :items
  end
end
