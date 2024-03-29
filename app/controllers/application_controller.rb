# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Utilities
  include Pundit
  alias current_user current_account
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_account!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def edit; end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:profile_pic, :email, :full_name, :username, :password, :password_confirmation, :kind)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:profile_pic, :email, :full_name, :username, :current_password, :password,
                         :password_confirmation, :kind)
    end
  end

  private

  def user_not_authorized
    flash[:notice] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
