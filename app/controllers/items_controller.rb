class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_item, only: %i[show edit update]
  before_action :authorize_owner!, only: %i[edit update]  # 出品者以外は弾く

  def index
    @items = Item.includes(:user, image_attachment: :blob).order(created_at: :desc)
  end

  def show; end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @item は set_item 済み
    # ※ 画面は new とほぼ同じ見た目にするのでフォームを部分テンプレ化して再利用します
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

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_owner!
    # 購入機能未実装のため「売却済みで弾く」は後で追加。今は出品者以外をトップへ。
    return if current_user == @item.user

    redirect_to root_path, alert: '権限がありません。'
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :status_id,
      :shipping_fee_id, :prefecture_id, :schedule_id, :price
    )
  end
end
