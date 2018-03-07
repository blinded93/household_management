class Household < ActiveRecord::Base
  include Shared

  has_secure_password

  has_many :members, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :rooms, dependent: :destroy

  validates :name, :city, :state, :zip_code, presence: true
  validates :address1, presence: true, uniqueness: true

  def members_attributes=(members_attributes)
    members_attributes.values.each do |member_attributes|
      self.members << Member.new(member_attributes)
    end
  end

  def heads
    members.where(head_of_household: true)
  end

  def cols
    [:name, :address1, :city, :state, :zip_code, :password]
  end

  def income
    self.members.pluck(:monthly_income).sum
  end
end
