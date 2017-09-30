class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :quantity, default: 1
      t.references :list, index: true
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :list_items, :lists
    add_foreign_key :list_items, :items
  end
end
