require 'rails_helper'
# Orderクラス モデルのテストですということを示している。
RSpec.describe Order, type: :model do
  describe '#valid?' do
    let(:name) { 'たけし' }
    let(:email) { 'test@gmail.com' }
    let(:telephone) { '09011111111' }
    let(:delivery_address) { '東京都杉並区高円寺北2-21-20' }
    let(:params) do
      {
        name:,
        email:,
        telephone:,
        delivery_address:
      }
    end
  # ↑ここまではテストデータ valid?メソッドに関しての

    subject { Order.new(params).valid? }

    it { is_expected.to eq true}

    # ↑ここまではテストケースを書く  eq は"イコール"の意味
    context '名前が空白の場合' do
      let(:name) {''}

      it { is_expected.to eq false}
    end

    context 'メールアドレスが空白の場合' do
      let(:email) {''}

      it { is_expected.to eq false}
    end

    context 'メールアドレスの書式が正しくない場合' do
      let(:email) {'sdgfsgmai.com'}

      it { is_expected.to eq false}
    end

    context '電話番号が空白の場合' do
      let(:telephone) {''}

      it { is_expected.to eq false}
    end

    context '電話番号が全角の場合' do
      let(:telephone) {'０９０６１１０２７２７'}

      it { is_expected.to eq true}
    end

    context '電話番号に数字以外が以外が含まれている場合' do
      let(:telephone) {'090-1111-1111'}

      it { is_expected.to eq true}
    end

    context '電話番号が12桁の場合' do
      let(:telephone) {'090111111111'}

      it { is_expected.to eq false}
    end

    context 'お届け先住所が空白の場合' do
      let(:delivery_address) {''}

      it { is_expected.to eq false}
    end
  end
end
