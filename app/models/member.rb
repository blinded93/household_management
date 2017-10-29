class Member < ActiveRecord::Base
  include Shared

  has_secure_password

  belongs_to :household
  has_many :chores
  has_one :room
  has_one :list
  has_many :recieved_messages, class_name: 'Message', primary_key: 'id', foreign_key: 'recipient_id'
  has_many :sent_messages, class_name: 'Message', primary_key: 'id', foreign_key: 'sender_id'

  after_initialize :assign_list

  def assign_list
    self.list || create_list(name: self.name)
  end

  def self.find_or_create_from_household_by(house, attrs)
    unless member = self.find_by(email: attrs[:email])
      member = house.members.create(attrs)
    end
    member
  end

  def name
    first_name
  end

  def plural
    self.name + "'s"
  end
end
