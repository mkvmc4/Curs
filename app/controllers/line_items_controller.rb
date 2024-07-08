class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[ show edit update destroy ]

  def index
    @line_items = LineItem.all
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    
   product = Product.find(params[:line_item][:product_id])
   @line_item = current_cart.add_product(product.id)

    if @line_item.save
      redirect_to cart_path(current_cart), notice: 'Product added to cart!'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
    
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to line_item_url(@line_item), notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart!'
  end

  private
   
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end
end
