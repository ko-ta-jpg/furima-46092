source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.0"
gem "sprockets-rails"
gem "puma", ">= 5.0"

# DB: 開発/テストは MySQL、本番は PostgreSQL
gem "mysql2", "~> 0.5"

# フロント
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# 便利系
gem "jbuilder"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

# 認証
gem "devise", "~> 4.9"

group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'factory_bot_rails'
  gem 'faker'

  gem 'debug', platforms: %i[mri windows]
  gem 'rubocop', '1.71.2', require: false
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem "pg", "~> 1.5"
end

gem 'active_hash'