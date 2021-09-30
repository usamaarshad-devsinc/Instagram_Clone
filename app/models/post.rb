# frozen_string_literal: true

class Post < ApplicationRecord
  include FollowedAccounts

  belongs_to :account
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validates :images, format: { with: /\.(png|jpg|jpeg)\z/i, message: 'only images are allowed' }
  validate :number_of_images

  private

  def number_of_images
    errors[:base] << ("You can't create an empty post [no image].") unless images.attached?
    errors[:base] << ("Post can't have more than 10 images.") unless images.size <= 10
  end
end
