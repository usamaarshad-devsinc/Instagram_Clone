# frozen_string_literal: true

module FollowedAccounts
  extend ActiveSupport::Concern

  included do
    scope :records_to_show, ->(account) { where(account_id: FollowedAccounts.followed_account_ids(account)).order(updated_at: :desc) } # rubocop:disable Layout/LineLength
  end

  def self.followed_account_ids(account)
    account.requests_sent.accepted_sent_requests.pluck(:recipient_id) << account.id
  end
end
