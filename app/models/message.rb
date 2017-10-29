class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates_presence_of :subject, :body, :sender_id, :recipient_id

  default_scope { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }
end
