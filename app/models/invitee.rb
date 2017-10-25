class Invitee < ActiveRecord::Base
  belongs_to :household
  has_secure_password

  validates :email, uniqueness: true

  def set_password
    self.password = [*'0'..'9', *'a'..'z', *'A'..'Z'].sample(8).join
  end
end
