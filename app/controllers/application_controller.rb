class ApplicationController < ActionController::Base
  # 本番のみ Basic 認証、有効性チェック用の /up は除外
  before_action :basic_auth,
                if:     -> { Rails.env.production? },
                unless: -> { request.path == "/up" }

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username.to_s, ENV.fetch("BASIC_AUTH_USER", "").to_s) &&
        ActiveSupport::SecurityUtils.secure_compare(password.to_s, ENV.fetch("BASIC_AUTH_PASSWORD", "").to_s)
    end
  end

  def configure_permitted_parameters
    added = [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday]
    devise_parameter_sanitizer.permit(:sign_up, keys: added)
    devise_parameter_sanitizer.permit(:account_update, keys: added)
  end
end