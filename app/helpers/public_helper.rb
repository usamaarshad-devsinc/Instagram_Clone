module PublicHelper
  def search_friends(email)
    Account.where('email LIKE ?', "%#{email}%" )
  end

  def followees_list(account)
    account.requests_sent.where(status: 'accepted').map{ |req| req.recipient }
  end

  def followers_list(account)
    account.requests_recieved.where(status: 'accepted').map{ |req| req.sender }
  end

  def already_followed?(recipient_id, sender_id)
    Request.exists?(recipient_id: recipient_id, sender_id: sender_id)
  end
end
