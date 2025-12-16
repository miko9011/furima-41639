# class Address < ApplicationRecord
#   extend ActiveHash::Associations::ActiveRecordExtensions

#   belongs_to :order
#   belongs_to :prefecture

#   # 郵便番号（ハイフン必須）
#   validates :postal_code, presence: true,
#             format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁-4桁」で入力してください" }

#   # 都道府県
#   validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

#   # 市区町村
#   validates :city, presence: true

#   # 番地
#   validates :address, presence: true

#   # 電話番号（10〜11桁、数字のみ）
#   validates :phone_number, presence: true,
#             format: { with: /\A\d{10,11}\z/, message: "は10桁か11桁の数字で入力してください" }
# end
