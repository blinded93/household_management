class Household < ActiveRecord::Base
  has_many :members
  has_many :bills
  has_many :rooms

  validates :name, presence: true
  validates :address1, presence: true, uniqueness: true
  validates :city, :state, :zip_code, presence: true

  def members_attributes=(members_attributes)
    members_attributes.values.each do |member_attributes|
      Member.find_or_create_from_household_by(self, member_attributes)
    end
  end
end
