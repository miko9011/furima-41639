class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # nickname
  validates :nickname, presence: true

  # birth date
  validates :birthday, presence: true

  # パスワード（英数字混合）
  validates :password,
            format: {
              with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
              message: "は半角英数字混合で入力してください"
            }

  # 名前（全角）
  validates :last_name, presence: true,
            format: {
              with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
              message: "は全角（漢字・ひらがな・カタカナ）で入力してください"
            }

  validates :first_name, presence: true,
            format: {
              with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
              message: "は全角（漢字・ひらがな・カタカナ）で入力してください"
            }

  # 名前（カナ）
  validates :last_name_kana, presence: true,
            format: {
              with: /\A[ァ-ヶー]+\z/,
              message: "は全角カタカナで入力してください"
            }

  validates :first_name_kana, presence: true,
            format: {
              with: /\A[ァ-ヶー]+\z/,
              message: "は全角カタカナで入力してください"
            }
end