class User < ApplicationRecord
  # Deviseが提供するログイン関連機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :last_name,  format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :last_name_kana,  format: { with: /\A[ァ-ヶー]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/ }
  end

  # 英字・数字を各1以上含み、かつ全角を含まないASCIIのみ
  validates :password, format: {
    with: /\A(?=.*[a-zA-Z])(?=.*\d)[!-~]+\z/, # スペースを除外（必要なら）
    message: 'には英字と数字の両方を含めて設定してください'
  }, if: -> { password.present? }
end
