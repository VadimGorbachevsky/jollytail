class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def show
    @cart = Cart.find(@user.cart_id)
  end

  def edit
  end

  def destroy
  end

  def update
    @user.update(name: params[:user][:name], email: params[:user][:email],  city: params[:user][:city],  telephone: params[:user][:telephone])
    redirect_to user_path(@user)
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :cart_id, :slug, :telephone, :city)
  end

  def cart_params
    params.require(:cart).permit(:id, :user_id, :slug)
  end

  def position_params
    params.require(:position).permit(:id, :product_id, :quantity)
  end

  def product_params
    params.require(:product).permit(:id, :name, :slug)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
