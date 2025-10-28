class Item < ApplicationRecord
  # 画像添付
  has_one_attached :image

  # 関連
  belongs_to :user
  has_one :order, dependent: :destroy # 購入機能用（後工程）

  # ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :schedule

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :schedule_id
  end

  # セレクトの「---」（id:1）を弾く
  with_options numericality: { other_than: 1, message: 'must be selected' } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :schedule_id
  end

  # 価格：半角数値／範囲
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            },
            allow_blank: true
end
