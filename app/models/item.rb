class Item < ActiveRecord::Base
  has_many :list_items
  has_many :lists, through: :list_items
  has_many :room_items
  has_many :rooms, through: :room_items

  def list_item(list)
    self.list_items.find_by(list_id:list.id)
  end
end
