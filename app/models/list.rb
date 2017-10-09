class List < ActiveRecord::Base
  belongs_to :room
  has_many :list_items
  has_many :items, through: :list_items

  def size
    items.count
  end
end
