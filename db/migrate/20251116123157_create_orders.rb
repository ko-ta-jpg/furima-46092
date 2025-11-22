class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end

    # item_id にユニーク制約を付けたいならこれだけでOK
    add_index :orders, :item_id, unique: true
  end
end
