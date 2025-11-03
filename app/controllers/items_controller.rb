
class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user).order(created_at: :desc) # 新しい順で表示
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity  # ← バリデーションエラー時に new を再描画
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :status_id,
      :shipping_fee_id, :prefecture_id, :schedule_id, :price
    )
  end
end