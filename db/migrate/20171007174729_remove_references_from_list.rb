class RemoveReferencesFromList < ActiveRecord::Migration
  change_table :lists do |t|
    t.remove_references :list_owner, polymorphic:true, index:true
  end
end
