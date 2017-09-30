class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :family_title
      t.integer :monthly_income, default:0
      t.string :email
      t.string :password_digest
      t.boolean :head_of_household, default:false
      t.references :household, index: true

      t.timestamps null: false
    end
    add_foreign_key :members, :households
  end
end
