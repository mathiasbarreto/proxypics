class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end  

  def new
    @order = Order.new
  end

  def create 
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order).permit(:address, :status, :photos, :requester_id)
  end
end
