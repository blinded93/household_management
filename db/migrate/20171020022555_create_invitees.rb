class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.references :household, index: true

      t.timestamps null: false
    end
    add_foreign_key :invitees, :households
  end
end
