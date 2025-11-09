# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    user

    name        { 'テスト商品' }
    description { '説明テキスト' }
    price       { 1000 }

    # ActiveHash の「---」回避のため 1 以外を指定
    category_id      { 2 }
    status_id        { 2 }
    shipping_fee_id  { 2 }
    prefecture_id    { 2 }
    schedule_id      { 2 }

    # ActiveStorage 画像を after(:build) で付与
    after(:build) do |item|
      path = Rails.root.join('spec/fixtures/files/test.png')
      item.image.attach(
        io: File.open(path),
        filename: 'test.png',
        content_type: 'image/png'
      )
    end

    # 便利トレイト（必要なら）
    trait :cheap do
      price { 299 }
    end

    trait :expensive do
      price { 10_000_000 }
    end
  end
end
