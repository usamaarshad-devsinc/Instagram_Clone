class ApplicationController < ActionController::Base
  before_action :authenticate_account!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:profile_pic, :email, :full_name, :username, :password, :password_confirmation, :is_private)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:profile_pic, :email, :full_name, :username,:current_password, :password, :password_confirmation, :is_private)
    end
  end
end
