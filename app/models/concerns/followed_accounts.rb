# frozen_string_literal: true

module FollowedAccounts
  extend ActiveSupport::Concern

  included do
    scope :records_to_show, ->(account) { where(account_id: followed_accounts(account)).order(updated_at: :desc) }
    scope :followed_accounts, lambda { |account|
                                account.requests_sent.accepted_sent_requests.pluck(:recipient_id) << account.id
                              }
  end
end
