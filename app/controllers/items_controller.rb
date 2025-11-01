
class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # トップページ表示。出品後はここへリダイレクト
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      # 入力値は画像・手数料・利益以外は残る（Railsの仕様通り）
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :price,
      :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_id,
      :image
    )
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :title, :description, :price,            # ← カラム名は :title で統一推奨
      :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_id,
      :image
    )
  end
end