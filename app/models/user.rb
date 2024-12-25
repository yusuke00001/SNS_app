class User < ApplicationRecord
has_many :comments
has_many :bookmarks
has_many :posts, through: :bookmarks

validates :name, presence: true
validates :email, presence: true, uniquness: true
end
