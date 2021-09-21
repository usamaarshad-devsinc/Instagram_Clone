# frozen_string_literal: true

module ApplicationHelper
  def already_liked?(post_id)
    Like.exists?(account_id: current_account.id, post_id: post_id)
  end

  def find_request(recipient)
    current_account.requests_sent.find_by(recipient_id: recipient.id)
  end
end
