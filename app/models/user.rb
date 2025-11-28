class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム
  validates :nickname, presence: true

  # 名前（全角）
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }

  # 名前（カナ）
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }

  # 生年月日
  validates :birthday, presence: true

  # パスワード（半角英数字混合）
  validates :password,
            format: {
              with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
              message: 'は半角英数字混合で入力してください'
            }
end
