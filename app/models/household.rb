class Household < ActiveRecord::Base
  has_secure_password

  has_many :members
  has_many :bills
  has_many :rooms
  has_many :invitees

  validates :name, presence: true
  validates :address1, presence: true, uniqueness: true
  validates :city, :state, :zip_code, presence: true

  def members_attributes=(members_attributes)
    members_attributes.values.each do |member_attribute|
      member = Member.new(member_attribute)
      if member.valid?
        member.household = self
        member.save
      else

      end
    end
  end

  def heads
    members.where(head_of_household: true).first
  end
end
