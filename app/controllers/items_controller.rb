# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_item, only: %i[show]

  def index
    @items = Item.with_attached_image.order(created_at: :desc)
  end

  def show
    # @item は set_item で取得済み
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity # ← バリデーションエラー時に new を再描画
    end
  end

  private

  def set_item
    @item = Item.find(params[:id]) # ← 定義
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :status_id,
      :shipping_fee_id, :prefecture_id, :schedule_id, :price
    )
  end
end
