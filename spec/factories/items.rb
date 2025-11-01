FactoryBot.define do
  factory :item do
    title       { "テスト商品" }
    description { "説明テキスト" }
    category_id { 1 }
    status_id   { 1 }
    shipping_fee_id { 1 }
    prefecture_id   { 1 }
    schedule_id     { 1 }
    price       { 1000 }
    association :user

    after(:build) do |item|
      # テスト用のダミー画像を添付
      item.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test.png")),
        filename: "test.png", content_type: "image/png"
      )
    end
  end
end