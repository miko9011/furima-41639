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

  def save
    order = Order.create!(
      user_id: user_id,
      item_id: item_id
    )

    Address.create!(
      postal_code: postal_code,  # ← そのまま保存
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end