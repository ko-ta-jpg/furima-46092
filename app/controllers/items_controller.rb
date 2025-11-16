# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_item,           only: %i[show edit update destroy]
  before_action :authorize_item!,     only: %i[edit update destroy]  

  def index
    @items = Item.includes(:user, image_attachment: :blob).order(created_at: :desc)
  end

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # 画像は新しく選ばれていない限りそのままなので「何も編集せず変更」でも画像は消えません
    if @item.update(item_params)
      redirect_to @item, notice: '商品情報を更新しました。'
    else
      # エラー時は edit に戻す（入力値は保持・画像/手数料/利益は要件上非表示のままでOK）
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
      @item.destroy
      redirect_to root_path, notice: '商品を削除しました。'
    end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_item!
    redirect_to root_path unless current_user == @item.user
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :status_id,
      :shipping_fee_id, :prefecture_id, :schedule_id, :price
    )
  end
end
