class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password_confirmation

  has_many :posts
  has_many :comments
  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :post

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
