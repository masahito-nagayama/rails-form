require 'rails_helper'

RSpec.describe "注文フォーム", type: :system do
  let(:name) { 'たけし' }
  let(:email) { 'test@gmail.com' }
  let(:telephone) { '09011111111' }
  let(:delivery_address) { '東京都杉並区高円寺北2-21-20' }

  it "商品を注文できること" do
    visit new_order_path

    fill_in "お名前", with: name
    fill_in "メールアドレス", with: email
    fill_in "電話番号", with: telephone
    fill_in "お届け先住所", with: delivery_address

    click_on "確認画面へ"

    expect(current_path).to eq confirm_orders_path

    click_on "OK"

    expect(current_path).to eq complete_orders_path
    expect(page).to have_content "#{name}様"

    # 完了ページを再訪すると、入力画面へ戻る。
    visit complete_orders_path
    expect(current_path).to eq new_order_path

    order = Order.last
    expect(order.name).to eq name
    expect(order.email).to eq email
    expect(order.telephone).to eq telephone
    expect(order.delivery_address).to eq delivery_address
  end
end
