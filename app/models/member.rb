class Member < ActiveRecord::Base
  # include Meta
  has_secure_password

  belongs_to :household
  has_many :chores
  has_one :room
  has_one :list, as: :list_owner

  scope :part_of, -> (household) { where(household_id: household.id)}

  def self.find_or_create_from_household_by(house, attrs)
    if !member = self.find_by(email: attrs[:email])
      house.members.build(attrs)
    else
      member
    end
  end
end
