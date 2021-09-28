# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user_is_owner_of_record?
  end

  def create?
    user_is_owner_of_record?
  end

  def edit?
    false
  end

  def update?
    user_is_owner_of_record? || user_is_recipient_of_record?
  end

  def destroy?
    user_is_owner_of_record? || user_is_recipient_of_record?
  end

  private

  def user_is_owner_of_record?
    account == record.sender
  end

  def user_is_recipient_of_record?
    account == record.recipient
  end
end
