require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  let(:order_id) { 123 }
  let(:expected_text_body) do
    <<~"MAILBODY"
    サンプルごりら様

    この度は、ご注文いただきありがとうございます。

    以下のご注文内容に基づき、商品を発送いたします。
    到着まで今しばらくお待ちください。

    [注文内容]
    商品:おいしいバナナ(100円/個)
    数量:3
    商品:おいしいたけし(200円/個)
    数量:2
    合計金額:770円(税込)

    支払い方法:1
    お届け先住所:東京都たけし市たけし町100丁目
    電話番号:09011111111
    その他・ご要望:テスト投稿です。がんばれよゴリラ
    メールマガジンの配信:配信を希望する

    --------------
    ゴリラ果物店
    メール:support@example.com
    --------------
    MAILBODY
  end

  let(:expected_html_body) do
    <<~"MAILBODY"
      <!DOCTYPE html>
      <html>
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
          <style>
            /* Email styles need to be inline */
          </style>
        </head>

        <body>
          サンプルごりら様<br>
      <br>
      この度は、ご注文いただきありがとうございます。<br>
      <br>
      以下のご注文内容に基づき、商品を発送いたします。<br>
      到着まで今しばらくお待ちください。<br>
      <br>
      [注文内容]<br>
      商品:おいしいバナナ(100円/個)<br>
      数量:3<br>
      商品:おいしいたけし(200円/個)<br>
      数量:2<br>
      合計金額:770円(税込)<br>
      <br>
      支払い方法:1<br>
      お届け先住所:東京都たけし市たけし町100丁目<br>
      電話番号:09011111111<br>
      その他・ご要望:テスト投稿です。がんばれよゴリラ<br>
      メールマガジンの配信:配信を希望する<br>
      <br>
      --------------<br>
      ゴリラ果物店<br>
      メール:<a href="mailt_to:support@example.com">support@example.com</a><br>
      --------------<br>
        </body>
      </html>
    MAILBODY
  end

  describe "#mail_to_user" do
    let(:delivered_mail) { OrderMailer.mail_to_user(order_id).deliver }
    let(:expected_to) { ["test@example.com"] }

    before do
      create(:order, id: order_id,
                      order_products_attributes: [
                        attributes_for(:order_product, product_id: 1, quantity: 3),
                        attributes_for(:order_product, product_id: 2, quantity: 2)
                      ])
    end

    it "正しいフォーマットでメールが作成される" do
      expect(delivered_mail.to).to eq expected_to
      expect(delivered_mail[:from].formatted).to eq ["support@example.com"]
      expect(delivered_mail.cc).to eq nil
      expect(delivered_mail.bcc).to eq nil
      expect(delivered_mail.subject).to eq "ご注文ありがとうございます"
      expect(delivered_mail.text_part.body.to_s).to eq expected_text_body.gsub(/\n/, "\r\n")
      expect(delivered_mail.html_part.body.to_s).to eq expected_html_body.gsub(/\n/, "\r\n")
    end
  end
end