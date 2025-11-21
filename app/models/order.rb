# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address

  # 1商品=1注文 を担保（DB側の unique と二重で堅くしたいなら）
  validates :item_id, uniqueness: true
end

# app/models/address.rb
class Address < ApplicationRecord
  belongs_to :order
end

# app/models/item.rb
class Item < ApplicationRecord
  has_one :order # 売却済み判定に使える（order.present?）
end
