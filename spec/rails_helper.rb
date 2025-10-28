# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
# 本番環境で誤ってテスト実行しないためのガード
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

# ---- ここから下は追加設定ゾーン ----

# FactoryBotのメソッド（build / create など）を使いやすくする
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # トランザクションでテストDBをきれいに保つ（Rails標準）
  config.use_transactional_fixtures = true

  # Railsの各種ヘルパーを自動で読み込む
  config.infer_spec_type_from_file_location!

  # backtraceをスッキリさせる
  config.filter_rails_from_backtrace!

  # FactoryBotの `build(:user)` をそのまま書けるように
  config.include FactoryBot::Syntax::Methods
end
