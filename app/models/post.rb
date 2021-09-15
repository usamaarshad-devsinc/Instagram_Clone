class Post < ApplicationRecord
  belongs_to :account
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validate :restrict_number_of_images

  def restrict_number_of_images
    if images.size > 10
      errors[:base] << ("Post can't have more than 10 images.")
    end
  end
end
