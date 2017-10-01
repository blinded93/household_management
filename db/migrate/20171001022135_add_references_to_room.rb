class AddReferencesToRoom < ActiveRecord::Migration
  def change
    add_reference :rooms, :member, index: true
    add_foreign_key :rooms, :members
    add_reference :rooms, :household, index: true
    add_foreign_key :rooms, :households
  end
end
