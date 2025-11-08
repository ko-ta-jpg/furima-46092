class ItemsController < ApplicationController
  # 出品はログイン必須、一覧は誰でも可
  before_action :authenticate_user!, only: %i[new create]

  def index
    # 新しい順。画像のN+1を避けるため ActiveStorage をプリロード
    @items = Item.includes(:user, image_attachment: :blob).order(created_at: :desc)
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
      :image, :name, :description, :price,
      :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_id
    )
  end
end
