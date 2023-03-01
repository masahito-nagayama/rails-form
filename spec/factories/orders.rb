FactoryBot.define do
  factory :order do
    name { "サンプルごりら" }
    email { "test@example.com" }
    telephone { "09011111111" }
    deliver_address { "東京都たけし市たけし町100丁目" }
    paymnet_method_id { 1 }
    other_comment { "テスト投稿です。がんばれよゴリラ" }
    direct_mail_enabled { true }
  end
end