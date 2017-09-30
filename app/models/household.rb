class Household < ActiveRecord::Base
  has_many :members
  has_many :bills
  has_many :rooms, as: :owner
end
