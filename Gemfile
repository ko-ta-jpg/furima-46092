# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.0'

gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.0'
gem 'sprockets-rails'

# DB: 開発/テストは MySQL、本番は PostgreSQL
gem 'mysql2', '~> 0.5'

# フロント
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# 便利系
gem 'bootsnap', require: false
gem 'jbuilder'
gem 'tzinfo-data', platforms: %i[windows jruby]

# 認証
gem 'devise', '~> 4.9'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rspec', require: false # あると便利
end

group :development do
  gem 'bootsnap', require: false
  gem 'rack-mini-profiler'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg', '~> 1.5'
end

gem 'active_hash'
