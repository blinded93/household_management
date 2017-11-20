class ListItem < ActiveRecord::Base
  include Joins

  belongs_to :list
  belongs_to :item

  def self.find_or_create(attrs)
    new_li = ListItem.new(attrs)
    if list_item = ListItem.find_by(list_id:new_li.list_id, item_id:new_li.item_id)
      list_item.update(attrs)
    else
      new_li.save
      new_li
    end
  end

  def item_attributes=(attrs)
    self.item = Item.find_or_create_by(attrs)
  end

  def columns
    ["brand", "info", "quantity"]
  end
end
