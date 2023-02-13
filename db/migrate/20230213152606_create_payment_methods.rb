class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods, comment: "支払い方法" do |t|
      t.string :name

      t.timestamps
    end
  end
end
