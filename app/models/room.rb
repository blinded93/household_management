class Room < ActiveRecord::Base
  # include Meta

  belongs_to :household
  belongs_to :member
  has_one :list, as: :list_owner
  has_many :room_items
  has_many :items, through: :room_items
end
