class List < ActiveRecord::Base
  belongs_to :list_owner, polymorphic:true
  has_many :list_items
  has_many :items, through: :list_items
end
