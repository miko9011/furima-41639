require 'rails_helper'

RSpec.describe User, type: :model do
  # テストデータの準備（FactoryBotを使用）
  before do
    # `build`メソッドを使用し、データベースに保存せずにインスタンスを作成
    @user = build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        # FactoryBotで作成したデータがバリデーションをパスするか確認
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが一致していれば登録できる' do
        # FactoryBotで設定されているため、正常系として確認
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      # ----------------------------------------
      # 必須項目（presence: true）のテスト
      # ----------------------------------------
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        # Deviseのバリデーションにより、password_confirmationも空であるとエラーを返す
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana は全角カタカナで入力してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana は全角カタカナで入力してください")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      # ----------------------------------------
      # 重複/形式（format, uniqueness）のテスト
      # ----------------------------------------
      it 'emailが重複していると登録できない' do
        # 既存のユーザーをDBに保存（Deviseの`uniqueness: true`を検証）
        create(:user, email: @user.email)
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testmail.com'
        @user.valid?
        # Deviseのデフォルトバリデーション
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      # ----------------------------------------
      # パスワードのテスト
      # ----------------------------------------
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが半角英数字混合でないと登録できない（数字のみ）' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字混合で入力してください")
      end

      it 'passwordが半角英数字混合でないと登録できない（英字のみ）' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字混合で入力してください")
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = 'different123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      # ----------------------------------------
      # 氏名（全角/カタカナ）のテスト
      # ----------------------------------------
      it 'last_nameが全角でないと登録できない（半角英字）' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'first_nameが全角でないと登録できない（半角英字）' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'last_name_kanaが全角カタカナでないと登録できない（ひらがな）' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角カタカナで入力してください")
      end

      it 'first_name_kanaが全角カタカナでないと登録できない（漢字）' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力してください")
      end
    end
  end
end