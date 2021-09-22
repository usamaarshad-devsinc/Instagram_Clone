# frozen_string_literal: true

class Story < ApplicationRecord
  include FollowedAccounts

  has_one_attached :image
  belongs_to :account
  validate :presence_check
  after_create :set_expiry

  # scope :stories_to_show, ->(account) { where(account_id: followed_accounts(account)).order(updated_at: :desc) }

  # def self.followed_accounts(account)
  #   ids = account.requests_sent.accepted_sent_requests.pluck(:recipient_id)
  #   ids << account.id
  # end

  private

  def presence_check
    errors[:base] << ("You can't create an empty story [no image].") unless image.attached?
  end

  def set_expiry
    StoryExpiresJob.set(wait: 24.hours).perform_later(id)
  end
end
