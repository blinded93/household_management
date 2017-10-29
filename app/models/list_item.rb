class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item

  def self.find_or_create(attrs, item)
    search_attrs = attrs.select{|key, value| key != 'quantity' && !value.is_a?(Hash)}
    search_attrs[:item_id] = item.id
    if list_item = ListItem.find_by(search_attrs)
      list_item.quantity += attrs[:quantity].to_i
    else
      list_item = ListItem.new(attrs)
    end
    list_item.save
    list_item
  end

  def item_attributes=(attrs)
    item = Item.create(attrs)
    self.item = item
    self.save
  end
end
