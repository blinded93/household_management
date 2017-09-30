class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :company
      t.string :utility
      t.integer :amount
      t.date :due_date
      t.integer :account_number
      t.references :household, index: true

      t.timestamps null: false
    end
    add_foreign_key :bills, :households
  end
end
