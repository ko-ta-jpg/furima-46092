require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.build(:item, user:) }

  before { item.image.attach(io: File.open('spec/fixtures/files/sample.png'), filename: 'sample.png') }

  context '出品できる' do
    it '必須項目が揃えば有効' do
      expect(item).to be_valid
    end
  end

  context '出品できない' do
    it '画像必須' do
      item.image = nil
      item.valid?
      expect(item.errors.full_messages).to include("Image can't be blank")
    end

    it '価格が空' do
      item.price = nil
      item.valid?
      expect(item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が範囲外（299）' do
      item.price = 299
      item.valid?
      expect(item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が範囲外（10000000）' do
      item.price = 10_000_000
      item.valid?
      expect(item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格が半角以外（全角）' do
      item.price = '３００'
      item.valid?
      expect(item.errors[:price]).not_to be_empty
    end

    it 'カテゴリが---(1)' do
      item.category_id = 1
      item.valid?
      expect(item.errors.full_messages).to include('Category must be selected')
    end
    # 他の ActiveHash 項目も同様に
  end
end
