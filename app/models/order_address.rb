# frozen_string_literal: true

class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number,
                :token

  # ▼ 必須チェック（空なら "can't be blank"）
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
  end

  # ▼ 郵便番号：3桁-4桁だけ許可（空のときはここはスキップ）
  validates :postal_code,
            format: {
              with: /\A\d{3}-\d{4}\z/,
              message: 'is invalid. Enter it as follows (e.g. 123-4567)'
            },
            allow_blank: true

  # ▼ 都道府県：「---」（id=1）以外
  validates :prefecture_id,
            numericality: { other_than: 1, message: 'must be selected' }

  # ▼ 電話番号：10〜11桁の数字のみ（ハイフン不可）
  validates :phone_number,
            format: { with: /\A\d{10,11}\z/ },
            allow_blank: true

  def save
    order = Order.create!(user_id:, item_id:)
    Address.create!(
      postal_code:, prefecture_id:, city:, addresses:, building:, phone_number:,
      order_id: order.id
    )
  end
end
