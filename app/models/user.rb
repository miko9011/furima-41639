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
              message: "is invalid. Include both letters and numbers"
            }

  # 名前（全角）
  validates :last_name, presence: true,
            format: {
              with: /\A[ぁ-んァ-ン一-龥々]+\z/,
              message: "is invalid. Input full-width characters"
            }

  validates :first_name, presence: true,
            format: {
              with: /\A[ぁ-んァ-ン一-龥々]+\z/,
              message: "is invalid. Input full-width characters"
            }

  # 名前（カナ）
  validates :last_name_kana, presence: true,
            format: {
              with: /\A[ァ-ヶー－]+\z/,
              message: "is invalid. Input full-width katakana characters"
            }

  validates :first_name_kana, presence: true,
            format: {
              with: /\A[ァ-ヶー－]+\z/,
              message: "is invalid. Input full-width katakana characters"
            }
end