# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:order_address) do
    described_class.new(
      user_id: user.id, item_id: item.id, token: 'tok_abcdefghijk00000000000000000',
      postal_code: '123-4567', prefecture_id: 2, city: '渋谷区', addresses: '神南1-1',
      building: 'ビル101', phone_number: '09012345678'
    )
  end

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
    it 'token必須' do
      order_address.token = ''
      order_address.valid?
      expect(order_address.errors[:token]).to include("can't be blank")
    end

    it 'postal_codeは3桁-4桁のみ' do
      order_address.postal_code = '1234567'
      order_address.valid?
      expect(order_address.errors[:postal_code]).to be_present
    end

    it 'prefecture_idは1以外' do
      order_address.prefecture_id = 1
      order_address.valid?
      expect(order_address.errors[:prefecture_id]).to be_present
    end

    it 'phone_numberはハイフンNG/10-11桁' do
      order_address.phone_number = '090-1234-5678'
      order_address.valid?
      expect(order_address.errors[:phone_number]).to be_present
    end
  end
end
