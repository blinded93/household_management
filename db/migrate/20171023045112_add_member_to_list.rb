class AddMemberToList < ActiveRecord::Migration
  def change
    add_reference :lists, :member, index: true
    add_foreign_key :lists, :members
  end
end
