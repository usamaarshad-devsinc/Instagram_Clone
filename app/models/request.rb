# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :recipient, class_name: 'Account'

  validates  :status, presence: true

  # enum status: { accepted: 0, pending: 1 }
  scope :accepted_sent_requests, -> { where(status: 'accepted') }
  scope :pending_requests_recieved, ->(account) { where(recipient_id: account.id, status: 'pending') }
end
