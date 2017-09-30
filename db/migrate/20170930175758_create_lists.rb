class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.references :list_owner, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_foreign_key :lists, :list_owners
  end
end
