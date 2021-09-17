# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validate :restrict_number_of_images

  private

  def restrict_number_of_images
    errors[:base] << ("You can't create an empty post [no image].") unless images.attached?
    errors[:base] << ("Post can't have more than 10 images.") unless images.size <= 10
  end
end
