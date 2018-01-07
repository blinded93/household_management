class ListItem < ActiveRecord::Base
  include Joins
  include Shared

  validates :quantity, :list_id, :item_id, :brand, :info, presence:true
  validate :unique?

  belongs_to :list
  belongs_to :item

  scope :for, -> (member) {
    joins(:list).
    where(lists: {member_id: member.id})
  }

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

  def cols
    [:item_id, :brand, :info, :quantity]
  end

  def columns
    ['brand', 'info', 'quantity']
  end

  def unique?
    if !persisted? && ListItem.find_by(list_id:list_id, item_id:item_id)
      errors.add(:item_id, "is already on that list.")
    end
  end

  def scopes
    {list.name.downcase.tr(" ", "_").to_sym => list.name}
  end

  def objects_hash(scope)
    {list:self.list}
  end
end
