class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.order_products.build
  end

  def confirm
    @order = Order.new(order_params)

    if params.key?(:add_product)
      # buttonが押されたら、OrderProductインスタンスを作成して複数商品を選択できるようにしているらしい
      @order.order_products << OrderProduct.new
      return render :new
    end

    if params.key?(:delete_product)
      filter_order_products
      return render :new
    end

    return render :new if @order.invalid?
  end

  def create
    @order = Order.new(order_params)
    return render :new if params[:button] == "back"

    if @order.save
      # userにメールを送信する。order_mailer.rbにmial_to_userというメソッドがあり、それが実行される。
      # OrderMailer.mail_to_user(@order.id).deliver
      # ↑の記述は、activejobの記述により不要のためコメントアウト perform_laterメソッドでキューに登録ができる (詳しくはRailsガイドを読め)
      # OrderMailerJob.perform_later(@order.id)
      # deliver_laterというものを使えば、↑のOrderMailerJobクラスを作らなくても非同期処理を実行することもできる。
      OrderMailer.mail_to_user(@order.id).deliver_later
      # sessionに保存する。
      session[:order_id] = @order.id
      return redirect_to complete_orders_url
    end
    # confirm.html.erbを表示するようにする
    render :confirm
  end

  def complete
    @order = Order.find_by(id: session[:order_id])
    return redirect_to new_order_url if @order.blank?

    session[:order_id] = nil
  end

  private

  def order_params
    params
      .require(:order)
      .permit(:name,
              :email,
              :telephone,
              :delivery_address,
              :payment_method_id,
              :other_comment,
              :direct_mail_enabled,
              inflow_source_ids: [],
              order_products_attributes: %i[product_id quantity])
  end

  def filter_order_products
    @order.order_products = @order.order_products.reject.with_index { |_, index| index == params[:delete_product].to_i }
  end
end
