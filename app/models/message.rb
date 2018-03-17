class Message < ActiveRecord::Base
  include Shared

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates_presence_of :subject, :body, :sender_id, :recipient_id

  default_scope { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  def sender
    Member.find_by(id: self.sender_id)
  end

  def recipient
    Member.find_by(id: self.recipient_id)
  end

  def cols
    [:subject, :body, :recipient_id, :sender_id]
  end
end
