class Member < ActiveRecord::Base
  include Shared

  has_secure_password

  validates_presence_of :first_name, :last_name, :email
  validate :positive_income
  validate :household_auth

  belongs_to :household
  has_many :chores, dependent: :destroy
  has_one :room, dependent: :destroy
  has_one :list, dependent: :destroy
  has_many :recieved_messages, class_name: 'Message', primary_key: 'id', foreign_key: 'recipient_id', dependent: :destroy
  has_many :sent_messages, class_name: 'Message', primary_key: 'id', foreign_key: 'sender_id', dependent: :destroy

  after_create :assign_list_and_room

  def assign_list_and_room
    if self.household
      create_list(name: self.name)
      create_room(name: self.name, household_id: self.household.id)
    end
  end

  def join_household(household)
    if !household.members.empty?
      self.head_of_household = false
    end
    self.household = household
    self.save
    self.assign_list_and_room
  end

  def self.scopes
    {member.name.downcase.to_sym => member.name}
  end

  def self.find_or_create_by_oauth(auth_hash)
    name = auth_hash[:name].split(" ")
    self.where(email:auth_hash["email"]).first_or_create do |member|
      member.first_name = name.first
      member.last_name = name.last
      member.password = SecureRandom.hex
      member.household_id = 0
      member.head_of_household = true
    end
  end

  def cols
    [:first_name, :last_name, :monthly_income, :email, :password]
  end

  def name
    first_name
  end

  def positive_income
    if monthly_income == nil || monthly_income < 0
      errors.add(:monthly_income, "cannot be below zero.")
    end
  end

  def household_auth
    if !head_of_household && household_id == nil
      errors.add(:base, "Household ID/passphrase don't match our records.")
    end
  end

  def first_head?
    self == self.household.members.first
  end
end
