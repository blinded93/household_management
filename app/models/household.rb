class Household < ActiveRecord::Base
  has_many :members
  has_many :bills
  has_many :rooms, as: :owner

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
end
