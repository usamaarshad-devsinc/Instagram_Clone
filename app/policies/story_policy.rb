# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.records_to_show(account)
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
    false
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    account == record.account
  end
end
