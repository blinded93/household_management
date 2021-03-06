class Item < ActiveRecord::Base
  include Shared

  validates :name, presence:true

  has_many :list_items
  has_many :lists, through: :list_items
  has_many :room_items
  has_many :rooms, through: :room_items

  def addee_item(addee)
    if addee.is_a?(List) || addee.is_a?(Room)
      @addee_item ||= addee.send("#{addee.class_name}_items").find_by(item_id:self.id)
    end
  end
end
