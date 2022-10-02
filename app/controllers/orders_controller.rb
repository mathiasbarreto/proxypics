class OrdersController < ApplicationController
  include Paginable

  def index
    @orders = Order.filter(filtered_params).with_attached_images.page(@page).per(@per_page)
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
    params.require(:order).permit(:id, :address, :status, images: [])
  end

  def filtered_params
    p = {}

    p[:status] = params[:status] if params[:status].present?
    p[:address] = params[:address] if params[:address].present?
    p[:status] = params[:status] if params[:status].present?
    p[:date] = {}
    p[:date][:start_date] = params[:start_date] if params[:start_date].present?
    p[:date][:end_date] = params[:end_date] if params[:end_date].present?
  
    p
  end
end
