class AddOtherCommentToOrders < ActiveRecord::Migration[7.0]
  def change
    # 任意の項目にしたいが、nullにはしたくない。そのためdefaultで空白を設定しておく。
    add_column :orders, :other_comment, :string, null: false, default: "", limit: 1000, comment: "その他・ご要望"
  end
end
