class Api::V1::OrdersController < ApplicationController
  include Paginable
  include Authenticable
  
  before_action :set_order, only: %i[show edit update]

  def index
    @orders = Order.filter(filtered_params).page(@page).per(@per_page)
    
    render json: @orders, status: 200
  end
  
  def show
    render json: @order
  end  

  def new
    @order = Order.new
  end

  def create 
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: 201
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def edit;end

  def update
    if @order.update(order_params)
      render json: @order, status: 200
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  
  private

  def set_order
    @order = Order.find(params[:id])
  end

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
