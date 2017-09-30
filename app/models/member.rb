class Member < ActiveRecord::Base
  # include Meta
  has_secure_password

  belongs_to :household
  has_many :rooms, as: :owner
  has_many :chores
end
