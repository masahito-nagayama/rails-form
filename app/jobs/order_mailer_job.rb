class OrderMailerJob < ApplicationJob
  queue_as :default

  # メソッド名は決まっているらしい
  def perform(order_id)
    sleep 30
    OrderMailer.mail_to_user(order_id).deliver
  end
end