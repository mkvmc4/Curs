class CartsController < ApplicationController
  
  def index
    @carts = Cart.all
  end

  def show
    @cart = Cart.find(params[:id])
    @line_items = @cart.line_items 
  end
  def new
    @cart = Cart.new
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @cart
      @cart.destroy!
      respond_to do |format|
        format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to carts_url, alert: "Cart not found."
    end
  end

  private
  
    def set_cart
      @cart = Cart.find(params[:id])
    end

   
    def cart_params
      params.fetch(:cart, {})
    end
end
