class Post < ApplicationRecord
  belongs_to :user

  has_many :bookmarks
  has_many :comments
  has_many :users, through: :bookmarks

  validates :title, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "title", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end

  def self.pagination_per_page
    10
  end
end
