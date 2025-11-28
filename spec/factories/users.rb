FactoryBot.define do
  factory :user do
    nickname { "テスト太郎" }
    email { Faker::Internet.unique.email }      # 一意のメールアドレス
    password { "abc123" }                       # 半角英数字混合
    password_confirmation { password }
    last_name { "山田" }                        # 全角
    first_name { "太郎" }                        # 全角
    last_name_kana { "ヤマダ" }                  # カタカナ
    first_name_kana { "タロウ" }                # カタカナ
    birthday { "2000-01-01" }                   # 生年月日
  end
end