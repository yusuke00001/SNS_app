class Comment < ApplicationRecord
  belongs_to :users
  belongs_to :posts

  validates :content, presence: true
end
