# frozen_string_literal: true

require 'payjp'

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid_access!

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
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

  def redirect_if_invalid_access!
    redirect_to root_path if current_user == @item.user || @item.order.present?
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token
    ).merge(
      user_id: current_user.id,
      item_id: @item.id
    )
  end

  def pay_item
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY')
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
