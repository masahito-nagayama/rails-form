require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  let(:order_id) { 123 }

  describe "#mail_to_user" do
    let(:delivered_mail) { OrderMailer.mail_to_user(order_id).deliver }
    let(:expected_to) { ["test@example.com"] }

    before do
      create(:order, id: order_id)
    end

    it "正しいフォーマットでメールが作成される" do
      expect(delivered_mail.to).to eq expected_to
      expect(delivered_mail.[:from].formatted).to eq ["support@example.com"]
      expect(delivered_mail.cc).to eq nil
      expect(delivered_mail.bcc).to eq nil
      expect(delivered_mail.subject).to eq "ご注文ありがとうございます"
      expect(delivered_mail.text_part.body.to_s).to eq expected_text_body.gsub(/\n/, "\r\n")
      expect(delivered_mail.html_part.body.to_s).to eq expected_text_body.gsub(/\n/, "\r\n")

    end
  end
end