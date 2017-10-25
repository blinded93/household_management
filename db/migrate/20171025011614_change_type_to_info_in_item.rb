class ChangeTypeToInfoInItem < ActiveRecord::Migration
  def change
    rename_column :items, :type, :info
  end
end
