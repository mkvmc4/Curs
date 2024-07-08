class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy add_to_cart]
  before_action :authenticate_user!, only: %i[add_to_cart]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  def add_to_cart
    product = Product.find(params[:id])
    
    @line_item = LineItem.new(product: product, cart: current_cart)

    if @line_item.save
      redirect_to cart_path, notice: 'Product added to cart!'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user&.admin?
  end
end
