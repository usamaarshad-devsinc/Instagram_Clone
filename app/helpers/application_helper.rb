# frozen_string_literal: true

module ApplicationHelper
  def already_liked?(post_id)
    Like.exists?(account_id: current_account.id, post_id: post_id)
  end

  def find_request(recipient)
    current_account.requests_sent.find_by(recipient_id: recipient.id)
  end

  def followees_count(account_id)
    Request.where(sender_id: account_id, status: 'accepted').count
  end

  def followers_count(account_id)
    Request.where(recipient_id: account_id, status: 'accepted').count
  end

  def request_accepted?(account)
    current_account.requests_sent.accepted_sent_requests.exists?(recipient_id: account.id )
  end
end
