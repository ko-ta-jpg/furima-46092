```mermaid

# ER図

erDiagram
  USERS ||--o{ ITEMS : "has many"
  USERS ||--o{ ORDERS : "has many"
  ITEMS ||--o{ ORDERS : "has one/has many"
  ORDERS ||--|| ADDRESSES : "has one"

  USERS {
    int    id PK
    string nickname
    string email
    string encrypted_password
    string last_name
    string first_name
    string last_name_kana
    string first_name_kana
    date   birth_date
  }

  ITEMS {
    int    id PK
    string name
    text   description
    int    category_id
    int    status_id
    int    shipping_fee_id
    int    prefecture_id
    int    schedule_id
    int    price
    int    user_id FK
  }

  ORDERS {
    int    id PK
    int    user_id FK
    int    item_id FK
  }

  ADDRESSES {
    int    id PK
    string postal_code
    int    prefecture_id
    string city
    string address
    string building
    string phone_number
    int    order_id FK
  }

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
