# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :recipient, class_name: 'Account'

  validates  :status, presence: true

  # enum status: { accepted: 0, pending: 1 }
  # scope :requested, ->(sender_id, recipient_id) { where(sender_id: sender_id, recipient_id: recipient_id) }
end
