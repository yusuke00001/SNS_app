class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_comment_notification

  validates :content, presence: true

  def send_comment_notification
    NotificationMailer.new_comment_notification(post.user, post, self).deliver_later
  end
end
