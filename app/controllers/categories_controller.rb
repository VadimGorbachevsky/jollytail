class CategoriesController < ApplicationController

  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @products = Product.joins(:productcount).order('productcounts.ordercount desc')
  end

  #items/1 GET
  def show
    @products = Product.where(category_id: @category.subtree_ids)
  end

  #items/1 GET
  def new
  end

  #items/1 GET
  def edit
  end

  #items POST
  def create
    @category = Category.create(category_params)
  end

  #items/1 PUT
  def update
    @category.update_attributes(category_params)
  end

  #items/1 DELETE
  def destroy
    @category.destroy
  end

  def category_params
    params.require(:сategory).permit(:name, :ancestry, :url, :real, :flags, :slug)
  end

  def product_params
    params.require(:product).permit(:name, :slug)
  end

  def productcount_params
    params.require(:productcount).permit(:id, :ordercount)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
