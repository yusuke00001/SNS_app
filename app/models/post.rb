class Post < ApplicationRecord
  has_many :bookmarks
  has_many :comments
  has_many :users, through: :bookmarks

  validates :title, presence: true
  validates :description, presence: true
end
