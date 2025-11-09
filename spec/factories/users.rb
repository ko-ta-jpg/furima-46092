# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname              { "user_#{SecureRandom.hex(4)}" }
    sequence(:email)      { |n| "user#{n}@example.com" } # ← こちらを使う
    password              { 'a1b2c3' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birthday              { Date.new(1990, 1, 1) }
  end
end
