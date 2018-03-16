class Household < ActiveRecord::Base
  include Shared

  has_secure_password

  has_many :members, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :rooms, dependent: :destroy

  validates :name, :city, :state, :zip_code, presence: true
  validates :address1, presence: true, uniqueness: true

  def cols
    [:name, :address1, :city, :state, :zip_code, :password]
  end
end
