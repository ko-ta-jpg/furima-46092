class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name
    validates :first_name
    validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :birthday
  end

  # パスワード英数混在（例）
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/ }, if: -> { password.present? }
end