module PublicHelper
  def search_friends(username)
    Account.where('email LIKE ?', "%#{username}%" )
  end

  def is_followed?(email)

  end

end
