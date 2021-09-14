class Post < ApplicationRecord
  belongs_to :account
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images

end
