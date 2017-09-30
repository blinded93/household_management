class Room < ActiveRecord::Base
  # include Meta

  belongs_to :owner, polymorphic:true
  has_one :lists, as: :list_owner

  scope :find_by_member, -> (member) { where(owner: member) }
  scope :find_by_household, -> (member) { where(owner: household) }
end
