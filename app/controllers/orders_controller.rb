class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = if current_user.restaurant?
                Order.joins(:food).where(foods: { user_id: current_user.id }).includes(:pickup_address, :delivery_address, :user)
              else
                current_user.orders.includes(:pickup_address, :delivery_address)
              end

    if params[:status].present?
      @orders = @orders.where(status: params[:status])
    elsif current_user.restaurant?
      @orders = @orders.where.not(status: :entregue)
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
    service = OrderManager::Creator.new(user: current_user, food_id: params[:food_id], order_params: params[:order])
    @order = service.call

    if @order.persisted?
      redirect_to @order, notice: "Pedido criado com sucesso."
    else
      @food = Food.find(params[:food_id])
      @restaurant = @food.user
      @restaurant_addresses = @restaurant.addresses
      @client_addresses = current_user.addresses
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @order = Order.find(params[:id])

    unless current_user.restaurant? && @order.food.user_id == current_user.id
      redirect_to orders_path, alert: "Você não tem permissão para editar este pedido."
    end
  end

  def update
    @order = Order.find(params[:id])
    service = OrderManager::Updater.new(user: current_user, order: @order, status_param: params[:order][:status])

    if service.call
      redirect_to orders_path, notice: "Status do pedido atualizado com sucesso."
    else
      redirect_to orders_path, alert: "Você não tem permissão para atualizar este pedido."
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
