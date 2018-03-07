class RemoveFamilyTitleFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :family_title, :string
  end
end
