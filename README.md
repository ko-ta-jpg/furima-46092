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