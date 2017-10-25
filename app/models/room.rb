class Room < ActiveRecord::Base
  include Shared

  belongs_to :household
  belongs_to :member
  has_many :room_items
  has_many :items, through: :room_items
end
