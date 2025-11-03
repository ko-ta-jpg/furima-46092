FactoryBot.define do
  factory :item do
    association :user
    name        { 'テスト商品' }
    description { '説明テキスト' }
    price       { 1000 }  # 値は任意だが 300~9,999,999 の範囲に

    # ←ここが重要（---=1 以外）
    category_id     { 2 }
    status_id       { 2 }
    shipping_fee_id { 2 }
    prefecture_id   { 2 }
    schedule_id     { 2 }

    after(:build) do |item|
      # 画像attachはこのまま（省略）
    end
  end
end