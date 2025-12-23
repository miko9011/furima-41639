require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it 'すべての項目が適切に入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '商品名が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では出品できない' do
        @item.description = ''
        @item.valid?
       expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが「---」だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '配送料の負担が「---」だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
         expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it '発送元の地域が「---」だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が「---」だと出品できない' do
        @item.delivery_time_id = 1
        @item.valid?
          expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end

      it '価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が数字でない場合は出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が300円未満では出品できない' do
        @item.price = 299
        @item.valid?
         expect(@item.errors.full_messages)
    .to include("Price must be greater than or equal to 300")
      end

      it '価格が10,000,000円以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
       expect(@item.errors.full_messages)
    .to include("Price must be less than or equal to 9999999")
      end

      it '画像が添付されていないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'user が紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end