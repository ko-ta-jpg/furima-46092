#!/usr/bin/env bash
# Render のビルド時に実行されるスクリプト
set -euxo pipefail

# 本番向け Bundler 設定（新しい推奨方式）
bundle config set --local without 'development test'
bundle install

# 本番環境でアセットをプリコンパイル
export RAILS_ENV=production
bundle exec rails assets:precompile

# DB マイグレーション（DATABASE_URL が設定されている場合のみ）
if [[ -n "${DATABASE_URL:-}" ]]; then
  bundle exec rails db:migrate
else
  echo "DATABASE_URL が無いので db:migrate をスキップします"
fi
