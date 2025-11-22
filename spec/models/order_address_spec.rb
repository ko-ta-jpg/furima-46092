require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:order_address) { build(:order_address, user_id: user.id, item_id: item.id) }

  context '購入できる' do
    it 'すべて揃っていれば有効' do
      expect(order_address).to be_valid
    end

    it 'buildingは空でも有効' do
      order_address.building = ''
      expect(order_address).to be_valid
    end
  end

  context '購入できない' do
    it 'user_idが空だと購入できない' do
      order_address.user_id = nil
      order_address.valid?
      expect(order_address.errors[:user_id]).to be_present
    end

    it 'item_idが空だと購入できない' do
      order_address.item_id = nil
      order_address.valid?
      expect(order_address.errors[:item_id]).to be_present
    end

    it 'tokenが空だと購入できない' do
      order_address.token = ''
      order_address.valid?
      expect(order_address.errors[:token]).to be_present
    end

    it 'postal_codeが空だと購入できない' do
      order_address.postal_code = ''
      order_address.valid?
      expect(order_address.errors[:postal_code]).to be_present
    end

    it 'postal_codeが3桁-4桁の形式でないと購入できない' do
      order_address.postal_code = '1234567'
      order_address.valid?
      expect(order_address.errors[:postal_code]).to be_present
    end

    it 'prefecture_idが空だと購入できない' do
      order_address.prefecture_id = nil
      order_address.valid?
      expect(order_address.errors[:prefecture_id]).to be_present
    end

    it 'prefecture_idが1だと購入できない' do
      order_address.prefecture_id = 1
      order_address.valid?
      expect(order_address.errors[:prefecture_id]).to be_present
    end

    it 'cityが空だと購入できない' do
      order_address.city = ''
      order_address.valid?
      expect(order_address.errors[:city]).to be_present
    end

    it 'addressesが空だと購入できない' do
      order_address.addresses = ''
      order_address.valid?
      expect(order_address.errors[:addresses]).to be_present
    end

    it 'phone_numberが空だと購入できない' do
      order_address.phone_number = ''
      order_address.valid?
      expect(order_address.errors[:phone_number]).to be_present
    end

    it 'phone_numberが9桁以下だと購入できない' do
      order_address.phone_number = '090123456'
      order_address.valid?
      expect(order_address.errors[:phone_number]).to be_present
    end

    it 'phone_numberが12桁以上だと購入できない' do
      order_address.phone_number = '090123456789'
      order_address.valid?
      expect(order_address.errors[:phone_number]).to be_present
    end

    it 'phone_numberにハイフンが含まれていると購入できない' do
      order_address.phone_number = '090-1234-5678'
      order_address.valid?
      expect(order_address.errors[:phone_number]).to be_present
    end
  end
end