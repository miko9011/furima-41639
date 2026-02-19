class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :address,
                :building_name, :phone_number,
                :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
    validates :user_id
    validates :item_id
    validates :token
  end

  # 郵便番号：123-4567形式
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }

  # 都道府県：1（---）は不可
  validates :prefecture_id,
          numericality: { other_than: 1, message: "can't be blank" }

  # 電話番号：10〜11桁の数字のみ
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

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