# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      # 1商品は1回しか購入できない前提ならユニーク制約を付ける
      t.references :item, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
    add_index :orders, :item_id, unique: true
  end
end
