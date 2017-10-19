class Member < ActiveRecord::Base
  include Shared

  has_secure_password

  belongs_to :household
  has_many :chores
  has_one :room
  has_many :recieved_messages, class_name: 'Message', primary_key: 'id', foreign_key: 'recipient_id'
  has_many :sent_messages, class_name: 'Message', primary_key: 'id', foreign_key: 'sender_id'

  def self.find_or_create_from_household_by(house, attrs)
    if !member = self.find_by(email: attrs[:email])
      house.members.build(attrs)
    else
      member
    end
  end

  def name
    first_name
  end

  def plural
    self.name + "'s"
  end
end
