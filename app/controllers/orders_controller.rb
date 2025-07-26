class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_client!

  def index
    @orders = current_user.orders.includes(:pickup_address, :delivery_address)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @restaurant = @product.user
    @restaurant_addresses = @restaurant.addresses
    @client_addresses = current_user.addresses
    @order = Order.new
  end

  def create
    @product = Product.find(params[:product_id])

    @order = current_user.orders.new(
      pickup_address_id: params[:order][:pickup_address_id],
      delivery_address_id: params[:order][:delivery_address_id],
      item_description: @product.name,
      requested_at: Time.current,
      estimated_value: @product.price,
      payment_method: params[:order][:payment_method],
      status: :confirmed
    )

    if @order.save
      redirect_to @order, notice: "Pedido criado com sucesso."
    else
      # recarrega as variáveis para renderizar novamente o form
      @restaurant = @product.user
      @restaurant_addresses = @restaurant.addresses
      @client_addresses = current_user.addresses
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ensure_client!
    redirect_to root_path, alert: "Apenas clientes podem criar pedidos." unless current_user.client?
  end
end
