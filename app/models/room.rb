class Room < ActiveRecord::Base
  include Shared

  belongs_to :household
  belongs_to :member
  has_one :list, as: :list_owner
  has_many :room_items
  has_many :items, through: :room_items

  after_initialize :assign_list

  def assign_list
    self.list || create_list(name: self.name)
  end
end
