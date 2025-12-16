class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image,        presence: true
  validates :name,         presence: true
  validates :description,  presence: true
  validates :price,        presence: true,
                           numericality: { message: "is not a number" }

  validates :category_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :sales_status_id,  numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id,  numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,    numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_time_id, numericality: { other_than: 1, message: "can't be blank" }
end