class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_unbuyable

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path, notice: "購入が完了しました"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_unbuyable
    if @item.order.present? || @item.user_id == current_user.id
      redirect_to root_path, alert: "この商品は購入できません"
    end
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address,
      :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']

    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end