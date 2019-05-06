class OrdersController < ApplicationController

  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def create
    @order = Order.create(user_id: current_user.id)
    @order.positions = current_user.cart.positions
    params[:order][:adress] ? @order.adress = params[:order][:adress] : ''
    current_user.cart.positions = []
    @order.positions.each do |pos|
      @productc = Productcount.where(product_id: pos.product_id).first
      @productc.count = @productc.count - pos.quantity
      @productc.ordercount = @productc.ordercount + pos.quantity
      @productc.save
    end
    OrderUMailer.with(user: current_user).you_order_email.deliver_now
    OrderUsMailer.with(user: current_user, order: @order).us_order_email.deliver_now
    flash[:notice] = "Ваш заказ поступил в обработку"
    redirect_to user_url(current_user)
  end

  def edit
     #Redurect to "restricted area" message
  end

  def destroy
  end

  def update
  end

  def decrease_counts
  end

  def order_params
    params.require(:order).permit(:id, :user_id, :adress)
  end

  def productcount_params
    params.require(:productcount).permit(:id, :count, :product_id, :ordercount)
  end

  def cart_params
    params.require(:cart).permit(:id)
  end

  def user_params
    params.require(:user).permit(:id, :cart_id, :name, :email)
  end

  def find_order
    @product = Product.find(params[:id])
  end

end
