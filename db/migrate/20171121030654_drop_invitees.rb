class DropInvitees < ActiveRecord::Migration
  def change
    remove_foreign_key(:invitees, :households)
    drop_table :invitees
  end
end
