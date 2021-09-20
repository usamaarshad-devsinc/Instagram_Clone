# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user_is_owner_of_record?
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record? || user_is_owner_of_post?
  end

  private

  def user_is_owner_of_record?
    account == record.account
  end

  def user_is_owner_of_post?
    account == record.post.account
  end
end
