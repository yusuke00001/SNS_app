class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_bookmark_notification

  validates :user_id, uniqueness: { scope: :post_id }

  def send_bookmark_notification
    NotificationMailer.new_bookmark_notification(post.user, post).deliver_later
  end

  def self.ransackable_associations(auth_object = nil)
    [ "post", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "user_id", "post_id" ]
  end

  def self.pagination_per_page
    10
  end
end
