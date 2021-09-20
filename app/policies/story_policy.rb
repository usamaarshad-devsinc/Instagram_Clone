# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(account_id: followed_accounts).order(updated_at: :desc)
    end

    private

    def followed_accounts
      ids = account.requests_sent.accepted_sent_requests.pluck(:recipient_id)
      ids << account.id
    end
  end

  def edit?
    false
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    account == record.account
  end
end
