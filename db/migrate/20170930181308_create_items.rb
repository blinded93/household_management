class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.integer :stock, default:0

      t.timestamps null: false
    end
  end
end
