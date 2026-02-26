class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :address,
                :building_name, :phone_number,
                :user_id, :item_id, :token

  # 郵便番号
  validates :postal_code,
            presence: true,
            format: { with: /\A\d{3}-\d{4}\z/ }

  # 都道府県
  validates :prefecture_id,
            presence: true,
            numericality: { other_than: 1, message: "can't be blank" }

  # 電話番号
  validates :phone_number,
            presence: true,
            format: { with: /\A\d{10,11}\z/ }

  # その他必須項目
  validates :city, presence: true
  validates :address, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :token, presence: true

  def save
    order = Order.create!(
      user_id: user_id,
      item_id: item_id
    )

    Address.create!(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end