class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.where('name LIKE ?  OR name1 LIKE ?', "%#{params[:q].chomp}%", "%#{params[:q].chomp}%")
  end

  def show
    if @product.real == false
      redirect_to _403_url
    end
  end

  def edit
     #Redurect to "restricted area" message
  end

  def destroy
  end

  def update
  end

  def update_all
    xlsx = Roo::Spreadsheet.open 'price_list.xlsx'
    @i = 1;
    @j = 1;
    @place = xlsx.sheet(0)
    while @place.cell(@i,@j) do
      if Product.exists?(@place.cell(@i,@j))
        @product = Product.find(@place.cell(@i,@j))
        @product.productcount.count = @place.cell(@i,@j+3) >=0 ? @place.cell(@i,@j+3) : 0
        @product.price = @place.cell(@i,@j+1)
        @product.action_price = @place.cell(@i,@j+2)
        @product.slug = Russian.translit(@product.name).parameterize
        @product.save
        @product.productcount.save
      else
        @product = Product.new(id: @place.cell(@i,@j), price: @place.cell(@i,@j+1), action_price: @place.cell(@i,@j+2), name: "default_name", category_id: 1, real: false)
        @productcount = Productcount.new(id: @place.cell(@i,@j), count: @place.cell(@i,@j+3) >=0 ? @place.cell(@i,@j+3) : 0)
        @product.productcount = @productcount
        @product.slug = Russian.translit(@product.name).parametrize
        @product.save
        @productcount.save
      end
      @j = @j + 4;
    end
    flash[:notice] = "База успешно обновлена"
    redirect_to admin_root_url
  end

  def product_params
    params.require(:product).permit(:id, :name, :image, :name1, :action_price, :real)
  end

  def productcount_params
    params.require(:productcount).permit(:id, :count)
  end

  def find_product
    if Product.exists?(params[:id])
      @product = Product.find(params[:id])
    else
      redirect_to _403_url
    end
  end

end
