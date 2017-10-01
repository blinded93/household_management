class Item < ActiveRecord::Base
  has_many :list_items
  has_many :lists, through: :list_items
  has_many :room_items
  has_many :rooms, through: :room_items
end
