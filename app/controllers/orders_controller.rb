class OrdersController < ApplicationController

  def index
    @orders = Order.filter(filtered_params)
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

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order).permit(:id, :address, :status, :photos)
  end

  def filtered_params
    params.slice(:address, :status, :start_date, :end_date)
  end
end
