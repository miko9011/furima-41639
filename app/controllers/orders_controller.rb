class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_unbuyable
  skip_before_action :verify_authenticity_token, only: :create

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
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

  # 🔒 購入不可条件をまとめてチェック
  def redirect_if_unbuyable
    # すでに購入済み、または自分の商品ならトップにリダイレクト
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
end