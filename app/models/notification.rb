class Notification < ApplicationRecord
  belongs_to :user
  enum status: { unread: 0, read: 1 }

  validates :title, presence: true
  validates :message, presence: true
end
