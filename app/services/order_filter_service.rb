class OrderFilterService
  include PeriodFilterHelper

  def self.call(current_user, params)
    new(current_user, params).call
  end

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    orders = base_orders_scope

    status_filter = @params.dig(:q, :status_eq)

    if status_filter.present?
      enum_status = Order.statuses[status_filter]
      @params[:q][:status_eq] = enum_status if enum_status


      unless [ "entregue", "cancelado" ].include?(status_filter)
        orders = orders.where.not(status: [ "entregue", "cancelado" ])
      end
    else
      orders = orders.where.not(status: [ "entregue", "cancelado" ])
    end

    if @params[:period].present?
      orders = PeriodFilterHelper.apply_period_filter(orders, @params[:period])
    end

    @q = orders.ransack(@params[:q])
    filtered_orders = @q.result

    result = {
      orders: filtered_orders.order(created_at: :desc).page(@params[:page]).per(6),
      search: @q,
      period: @params[:period]
    }

    if @current_user.cliente?
      result[:restaurants] = client_restaurants
    end

    result
  end

  private

  def base_orders_scope
    if @current_user.restaurante?
      Order.joins(:food)
           .where(foods: { user_id: @current_user.id })
           .includes(:pickup_address, :delivery_address, :user, food: :user)
    else
      @current_user.orders.includes(:pickup_address, :delivery_address, food: :user)
    end
  end

  def client_restaurants
    User.joins(:foods, foods: :orders)
        .where(orders: { user_id: @current_user.id })
        .where(role: :restaurante)
        .distinct
        .select(:id, :email)
  end
end
