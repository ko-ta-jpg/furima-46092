class ApplicationController < ActionController::Base
  # 本番環境のときだけBasic認証をかける
  before_action :basic_auth, if: :production_env?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 安全な比較（タイミング攻撃対策）
      ActiveSupport::SecurityUtils.secure_compare(
        username,
        ENV.fetch('BASIC_AUTH_USER', '')
      ) &&
        ActiveSupport::SecurityUtils.secure_compare(
          password,
          ENV.fetch('BASIC_AUTH_PASSWORD', '')
        )
    end
  end

  # 本番だけ true にする
  def production_env?
    Rails.env.production?
  end

  # Deviseのストロングパラメータ許可
  def configure_permitted_parameters
    added = [
      :nickname,
      :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :birthday
    ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added)
  end
end
