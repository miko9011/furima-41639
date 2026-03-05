class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

 def basic_auth
  return unless ENV["BASIC_AUTH_USER"].present? && ENV["BASIC_AUTH_PASSWORD"].present?

  authenticate_or_request_with_http_basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(username, ENV["BASIC_AUTH_USER"]) &
    ActiveSupport::SecurityUtils.secure_compare(password, ENV["BASIC_AUTH_PASSWORD"])
  end
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname, :last_name, :first_name,
      :last_name_kana, :first_name_kana, :birthday
    ])
  end
end