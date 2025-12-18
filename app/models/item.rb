class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: 'は300円から9,999,999円の間で入力してください'
            }

  validates :category_id,      numericality: { other_than: 1, message: 'を選択してください' }
  validates :sales_status_id,  numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_fee_id,  numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id,    numericality: { other_than: 1, message: 'を選択してください' }
  validates :delivery_time_id, numericality: { other_than: 1, message: 'を選択してください' }
end