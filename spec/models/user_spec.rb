require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context '新規登録できるとき' do
    it '全部正しく入力されていれば登録できる' do
      expect(user).to be_valid
    end
  end

  context '新規登録できないとき' do
    it 'nicknameが空だと登録できない' do
      user.nickname = ''
      expect(user).to be_invalid
      expect(user.errors[:nickname]).to be_present
    end

    it '重複したメールアドレスは登録できない' do
      create(:user, email: 'dup@example.com')
      user.email = 'dup@example.com'
      expect(user).to be_invalid
      expect(user.errors[:email]).to be_present
    end

    it 'メールアドレスに@を含まない場合は登録できない' do
      user.email = 'invalid-email'
      expect(user).to be_invalid
      expect(user.errors[:email]).to be_present
    end

    it '全角文字を含むパスワードでは登録できない' do
      user.password = user.password_confirmation = 'ａｂｃ123' # 全角含む
      expect(user).to be_invalid
      expect(user.errors[:password]).to be_present
    end

    it 'パスワードと確認用が不一致だと登録できない' do
      user.password = 'abc123'
      user.password_confirmation = 'abc124'
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to be_present
    end

    it 'passwordが英字のみでは登録できない' do
      user.password = user.password_confirmation = 'abcdef'
      expect(user).to be_invalid
      expect(user.errors[:password]).to be_present
    end

    it 'passwordが数字のみでは登録できない' do
      user.password = user.password_confirmation = '123456'
      expect(user).to be_invalid
      expect(user.errors[:password]).to be_present
    end

    it '姓（全角）に半角が含まれると登録できない' do
      user.last_name = 'Yamada'
      expect(user).to be_invalid
      expect(user.errors[:last_name]).to be_present
    end

    it '名（全角）に半角が含まれると登録できない' do
      user.first_name = 'Taro'
      expect(user).to be_invalid
      expect(user.errors[:first_name]).to be_present
    end

    it '姓（カナ）がカタカナ以外を含むと登録できない' do
      user.last_name_kana = 'やまだ'
      expect(user).to be_invalid
      expect(user.errors[:last_name_kana]).to be_present
    end

    it '名（カナ）がカタカナ以外を含むと登録できない' do
      user.first_name_kana = 'たろう'
      expect(user).to be_invalid
      expect(user.errors[:first_name_kana]).to be_present
    end

    it '生年月日が空だと登録できない' do
      user.birthday = nil
      expect(user).to be_invalid
      expect(user.errors[:birthday]).to be_present
    end
  end
end
