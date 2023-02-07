class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
  end

  def create
    @order = Order.new(order_params)
    return render :new if params[:button] == "back"
    # if文が1行しかない場合は、ifを後ろに置いて1行で記述する。
    return redirect_to complete_orders_url if @order.save
    # confirm.html.erbを表示するようにする
    render :confirm
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :telephone, :delivery_address)
  end
end
