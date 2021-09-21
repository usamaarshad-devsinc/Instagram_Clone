# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validate :restrict_number_of_images

  scope :posts_to_show, ->(account) { where(account_id: followed_accounts(account)).order(updated_at: :desc) }

  def self.followed_accounts(account)
    ids = account.requests_sent.accepted_sent_requests.pluck(:recipient_id)
    ids << account.id
  end

  private

  def restrict_number_of_images
    errors[:base] << ("You can't create an empty post [no image].") unless images.attached?
    errors[:base] << ("Post can't have more than 10 images.") unless images.size <= 10
  end
end
