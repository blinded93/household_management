class Member < ActiveRecord::Base
  # include Meta
  has_secure_password

  belongs_to :household
  has_many :chores
  has_one :room
end
