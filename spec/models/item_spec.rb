require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:item) { build(:item, user: user) }

  before do
    # 画像を添付（spec/fixtures/files/sample.png を用意しておく）
    item.image.attach(
      io: File.open(Rails.root.join('spec/fixtures/files/sample.png')),
      filename: 'sample.png',
      content_type: 'image/png'
    )
  end

  context '出品できる' do
    it '必須項目が揃えば有効' do
      expect(item).to be_valid
    end
  end

  context '出品できない' do
    it '画像が必須' do
      item.image = nil
      item.valid?
      expect(item.errors.full_messages).to include("Image can't be blank")
    end

    it 'タイトル必須' do
      item.name = ''
        item.valid?
        expect(item.errors.full_messages).to include("Name can't be blank")
    end

    it '説明必須' do
      item.description = ''
      item.valid?
      expect(item.errors.full_messages).to include("Description can't be blank")
    end

    it '価格が空' do
      item.price = nil
      item.valid?
      expect(item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が299以下' do
      item.price = 299
      item.valid?
      expect(item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が1000万以上' do
      item.price = 10_000_000
      item.valid?
      expect(item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格が全角など半角以外' do
      item.price = '３００'
      item.valid?
      expect(item.errors.full_messages).to include('Price is not a number')
    end

    it 'カテゴリが---(id:1)' do
      item.category_id = 1
      item.valid?
      expect(item.errors.full_messages).to include('Category must be selected')
    end

    it '状態が---(id:1)' do
      item.status_id = 1
      item.valid?
      expect(item.errors.full_messages).to include('Status must be selected')
    end

    it '配送料負担が---(id:1)' do
      item.shipping_fee_id = 1
      item.valid?
      expect(item.errors.full_messages).to include('Shipping fee must be selected')
    end

    it '都道府県が---(id:1)' do
      item.prefecture_id = 1
      item.valid?
      expect(item.errors.full_messages).to include('Prefecture must be selected')
    end

    it '発送までの日数が---(id:1)' do
      item.schedule_id = 1
      item.valid?
      expect(item.errors.full_messages).to include('Schedule must be selected')
    end
  end
end

