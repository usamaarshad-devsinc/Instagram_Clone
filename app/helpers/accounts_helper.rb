# frozen_string_literal: true

module AccountsHelper
  def search_friends(query)
    Account.where('email ILIKE :q OR username ILIKE :q OR full_name ILIKE :q', q: "%#{query}%").order(:email)
  end

  def followees_list(account)
    account.requests_sent.where(status: 'accepted').map(&:recipient)
  end

  def followers_list(account)
    account.requests_recieved.where(status: 'accepted').map(&:sender)
  end

  def already_followed?(recipient_id, sender_id)
    Request.exists?(recipient_id: recipient_id, sender_id: sender_id)
  end
end
