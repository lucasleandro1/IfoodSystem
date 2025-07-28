class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.restaurant?
      @orders = Order.joins(:food)
                    .where(foods: { user_id: current_user.id })
                    .includes(:pickup_address, :delivery_address, :user)
    else
      @orders = current_user.orders.includes(:pickup_address, :delivery_address)
    end

    if params[:status].present?
      @orders = @orders.where(status: params[:status])
    else
      @orders = @orders.where.not(status: :entregue) if current_user.restaurant?
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
      status: :pendente
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

  def edit
    @order = Order.find(params[:id])

    unless current_user.restaurant? && @order.food.user_id == current_user.id
      redirect_to orders_path, alert: "Você não tem permissão para editar este pedido."
    end
  end

  def update
    @order = Order.find(params[:id])

    if current_user.restaurant? && @order.food.user_id == current_user.id
      if params[:order][:status] == "cancelado"
        if @order.update(status: :cancelado)
        redirect_to orders_path, notice: "Pedido cancelado."
        end
      elsif @order.update(order_params)
        redirect_to orders_path, notice: "Status do pedido atualizado com sucesso."
      else
        redirect_to orders_path, alert: "Erro ao atualizar o status."
      end

    elsif current_user.client? && @order.user_id == current_user.id && @order.pendente?
      if params[:order][:status] == "cancelado"
        if @order.update(status: :cancelado)
        redirect_to orders_path, notice: "Pedido cancelado."
        end
      else
        redirect_to orders_path, alert: "Ação não permitida."
      end

    else
      redirect_to orders_path, alert: "Você não tem permissão para atualizar este pedido."
    end
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end
end
