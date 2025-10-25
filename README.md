```mermaid
erDiagram
  USERS ||--o{ ITEMS : has
  USERS ||--o{ PURCHASES : has
  ITEMS ||--o{ PURCHASES : has
  PURCHASES ||--|| ADDRESSES : has

  USERS { string nickname string email string encrypted_password date birth_date }
  ITEMS { string title integer price integer category_id integer condition_id integer shipping_charge_id integer prefecture_id integer shipping_day_id }
  PURCHASES { }
  ADDRESSES { string postal_code integer prefecture_id string city string street string building string phone_number }


# テーブル設計

## users テーブル

| Column               | Type   | Options                          |
| -------------------- | ------ | -------------------------------- |
| nickname             | string | null: false                      |
| email                | string | null: false, unique: true        |
| encrypted_password   | string | null: false                      |
| last_name            | string | null: false                      |
| first_name           | string | null: false                      |
| last_name_kana       | string | null: false                      |
| first_name_kana      | string | null: false                      |
| birth_date           | date   | null: false                      |

### Association

- has_many :items
- has_many :orders


## items テーブル

出品された商品の情報を保存するテーブル

| Column             | Type       | Options                          |
| ------------------ | ---------- | -------------------------------- |
| name               | string     | null: false                      |
| description        | text       | null: false                      |
| category_id        | integer    | null: false                      |
| status_id          | integer    | null: false                      | 
| shipping_fee_id    | integer    | null: false                      | 
| prefecture_id      | integer    | null: false                      | 
| schedule_id        | integer    | null: false                      | 
| price              | integer    | null: false                      |
| user               | references | null: false, foreign_key: true   |

※ `_id` がついているカラム（category_idなど）は ActiveHash を使う想定のプルダウン。  
　「---」など選択不可の値(=1)を含めたバリデーションをモデル側で行う。

### Association

- belongs_to :user
- has_one :order


## orders テーブル

どのユーザーがどの商品を購入したかを管理するテーブル  
（購入履歴／決済情報本体）

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

購入時の配送先住所を保存するテーブル  
（ordersテーブルと1対1で紐づく）

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| address          | string     | null: false                    |
| building         | string     |                                |
| phone_number     | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to :order
