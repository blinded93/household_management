class Room < ActiveRecord::Base
  # include Meta

  belongs_to :household
  has_one :lists, as: :list_owner
  has_many :room_items
  has_many :items, through: :room_items
end
