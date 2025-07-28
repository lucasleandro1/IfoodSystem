class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.restaurant?
      @orders = Order.joins(:food).where(foods: { user_id: current_user.id }).includes(:pickup_address, :delivery_address, :user)
    else
      @orders = current_user.orders.includes(:pickup_address, :delivery_address)
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @food = Food.find(params[:food_id])
    @restaurant = @food.user
    @restaurant_addresses = @restaurant.addresses
    @client_addresses = current_user.addresses
    @order = Order.new
  end

  def create
    @food = Food.find(params[:food_id])
    quantity = params[:order][:quantity].to_i
    @order = current_user.orders.new(
      food_id: @food.id,
      quantity: quantity,
      pickup_address_id: params[:order][:pickup_address_id],
      delivery_address_id: params[:order][:delivery_address_id],
      item_description: @food.name,
      requested_at: Time.current,
      estimated_value: @food.price * quantity,
      payment_method: params[:order][:payment_method],
      status: :pendent
    )

    if @order.save
      redirect_to @order, notice: "Pedido criado com sucesso."
    else
      @restaurant = @food.user
      @restaurant_addresses = @restaurant.addresses
      @client_addresses = current_user.addresses
      render :new, status: :unprocessable_entity
    end
  end
end
