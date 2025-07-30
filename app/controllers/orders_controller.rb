class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = if current_user.restaurante?
                Order.joins(:food).where(foods: { user_id: current_user.id }).includes(:pickup_address, :delivery_address, :user, food: :user)
    else
                current_user.orders.includes(:pickup_address, :delivery_address, food: :user)
    end

    if params[:status].present?
      @orders = @orders.where(status: params[:status])
    else
      @orders = @orders.where.not(status: [ "entregue", "cancelado" ])
    end

    if params[:date].present?
      date = Date.parse(params[:date])
      @orders = @orders.where(requested_at: date.beginning_of_day..date.end_of_day)
    end

    if params[:period].present?
      case params[:period]
      when "today"
        @orders = @orders.where(requested_at: Date.current.beginning_of_day..Date.current.end_of_day)
      when "week"
        @orders = @orders.where(requested_at: 1.week.ago.beginning_of_day..Time.current)
      when "month"
        @orders = @orders.where(requested_at: 1.month.ago.beginning_of_day..Time.current)
      end
    end

    if current_user.cliente? && params[:restaurante_id].present?
      @orders = @orders.joins(:food).where(foods: { user_id: params[:restaurante_id] })
    end

    @orders = @orders.order(created_at: :desc)
    @orders = @orders.page(params[:page]).per(6)

    if current_user.cliente?
      @restaurantes = User.joins(:foods, foods: :orders)
                        .where(orders: { user_id: current_user.id })
                        .where(role: :restaurante)
                        .distinct
                        .select(:id, :email)
    end
  end

  def user_orders
    if params[:user_id].present? && (current_user.id == params[:user_id].to_i)
      user = User.find(params[:user_id])
      @orders = user.orders.includes(:pickup_address, :delivery_address, :food)
      render json: @orders.as_json(include: [ :pickup_address, :delivery_address, :food ])
    else
      render json: { error: "Não autorizado" }, status: :unauthorized
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @food = Food.find(params[:food_id])
    @restaurante = @food.user
    @restaurante_addresses = @restaurante.addresses
    @cliente_addresses = current_user.addresses
    @order = Order.new
  end

  def create
    service = OrderManager::Creator.new(user: current_user, food_id: params[:food_id], order_params: params[:order])

    begin
      @order = service.call

      if @order.persisted?
        redirect_to @order, notice: "Pedido criado com sucesso."
      else
        @food = Food.find(params[:food_id])
        @restaurante = @food.user
        @restaurante_addresses = @restaurante.addresses
        @cliente_addresses = current_user.addresses
        render :new, status: :unprocessable_entity
      end
    rescue ArgumentError => e
      @food = Food.find(params[:food_id])
      @restaurante = @food.user
      @restaurante_addresses = @restaurante.addresses
      @cliente_addresses = current_user.addresses
      @order = Order.new
      @order.errors.add(:base, e.message)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @order = Order.find(params[:id])

    unless current_user.restaurante? && @order.food.user_id == current_user.id
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
