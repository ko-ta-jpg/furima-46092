# frozen_string_literal: true

# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
# 本番環境で誤ってテスト実行しないためのガード
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

# ---- ここから下は追加設定ゾーン ----

RSpec.configure do |config|
  # ↓ Rails の fixture 機能は使わないので、あってもなくてもどちらでもOK
  # config.fixture_path = Rails.root.join('spec/fixtures').to_s

  # ▼ ここがポイント１：トランザクションフィクスチャをオフにする
  #   （ActiveRecord::TestFixtures が Fiber＋MySQL でコケるのを避ける）
  config.use_transactional_fixtures = false

  # ▼ ここがポイント２：fixtures 自体も使わない宣言
  config.use_fixtures = false if config.respond_to?(:use_fixtures=)

  # Railsの各種ヘルパーを自動で読み込む
  config.infer_spec_type_from_file_location!

  # backtraceをスッキリさせる
  config.filter_rails_from_backtrace!

  # FactoryBotの `build(:user)` などをそのまま使えるように
  config.include FactoryBot::Syntax::Methods

  # spec/support 以下のヘルパー読み込み
  Rails.root.glob('spec/support/**/*.rb').each { |f| require f }
end
