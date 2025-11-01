class User < ApplicationRecord
  # Deviseが提供するログイン関連機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

<<<<<<< Updated upstream
  # 必須チェック
  validates :nickname, presence: true
  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                                  message: '全角文字を使用してください' }
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                                   message: '全角文字を使用してください' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー]+\z/,
                                       message: '全角カタカナを使用してください' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー]+\z/,
                                        message: '全角カタカナを使用してください' }
  validates :birthday, presence: true

  # パスワードは devise が以下を勝手にやってくれる:
  # - presence: true
  # - 長さ6文字以上
  # - 確認用と一致してるか確認

  # それに加えて「半角英数字混合(英字と数字どっちも含む)」だけは自分で追加する
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'には英字と数字の両方を含めて設定してください' },
            on: :create
=======
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
>>>>>>> Stashed changes
end
