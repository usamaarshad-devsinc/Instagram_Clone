# frozen_string_literal: true

class Story < ApplicationRecord
  include FollowedAccounts

  has_one_attached :image
  belongs_to :account
  validates :image, format: { with: /\.(png|jpg|jpeg)\z/i, message: 'only images are allowed' }
  validate :presence_check
  after_create :set_expiry

  private

  def presence_check
    errors[:base] << ("You can't create an empty story [no image].") unless image.attached?
  end

  def set_expiry
    StoryExpiresJob.set(wait: 24.hours).perform_later(id)
  end
end
