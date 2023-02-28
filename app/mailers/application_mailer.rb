# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # ここが差し出し元のメールアドレスになる。どこからメールが送られてくるのかを記載する。
  default from: 'support@example.com'
  layout 'mailer'
end
