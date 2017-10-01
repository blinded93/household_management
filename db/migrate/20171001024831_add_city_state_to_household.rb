class AddCityStateToHousehold < ActiveRecord::Migration
  def change
    remove_column :households, :address
    add_column :households, :address1, :string
    add_column :households, :address2, :string
    add_column :households, :city, :string
    add_column :households, :state, :string
    add_column :households, :zip_code, :integer
  end
end
