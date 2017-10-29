class AddBrandToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :brand, :string
    add_column :list_items, :info, :string
    remove_column :items, :info
  end
end
