class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :order
  belongs_to :prefecture

  validates :postal_code, presence: true,
            format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁-4桁」で入力してください" }

  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true,
            format: { with: /\A\d{10,11}\z/, message: "は10桁か11桁の数字で入力してください" }
end