class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :owner, polymorphic:true, index: true

      t.timestamps null: false
    end
    add_foreign_key :rooms, :owners
  end
end
