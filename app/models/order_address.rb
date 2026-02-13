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
    item = Item.find(item_id)

    # 🔐 秘密鍵は環境変数から取得
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']

    # 💳 決済処理
    Payjp::Charge.create(
      amount: item.price,
      card: token,
      currency: 'jpy'
    )

    # 🧾 注文保存
    order = Order.create!(
      user_id: user_id,
      item_id: item_id
    )

    # 🏠 住所保存
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