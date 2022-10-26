class OrdersController < ApplicationController
  include Paginable
  before_action :authenticate!
  before_action :set_start_and_end_date
  before_action :set_order, only: %i[show edit update destroy]
  
  def index
    @orders = Order.filter(filtered_params).with_attached_images
                   .page(@page).per(@per_page)
                   .order(created_at: :desc)

                   
                   # The `geocoded` scope filters only flats with coordinates
    @markers = @orders.geocoded.map do |order|
                     {
                       lat: order.latitude,
                       lng: order.longitude
                     }
                   end
                 
  end
  
  def show
    @marker = {lat: @order.latitude, lng: @order.longitude}
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

  def edit;end
  

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
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
    p[:date][:start_date] = @start_date 
    p[:date][:end_date] = @end_date
  
    p
  end

  def set_start_and_end_date
    @start_date = params[:start_date].present? ? params[:start_date] : Time.zone.today - 180.days
    @end_date = params[:end_date].present? ? params[:end_date] : Time.zone.today
  end

  def authenticate!
    unless requester_signed_in? || assignee_signed_in?
      authenticate_requester! || authenticate_assignee!
    end
  end
end
