class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold
    redirect_to root_path if @item.order.present?
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