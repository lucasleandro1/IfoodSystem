module OrderManager
  class Creator
    def initialize(user:, food_id:, order_params:)
      @user = user
      @food = Food.find(food_id)
      @params = order_params
    end

    def call
      validate_params!
      
      quantity = @params[:quantity].to_i
      order = @user.orders.new(
        food_id: @food.id,
        quantity: quantity,
        pickup_address_id: @params[:pickup_address_id],
        delivery_address_id: @params[:delivery_address_id],
        item_description: @food.name,
        requested_at: Time.current,
        estimated_value: @food.price * quantity,
        payment_method: @params[:payment_method],
        status: :pendente
      )
      order.save
      order
    end

    private

    def validate_params!
      errors = []
      
      errors << "Endereço de coleta é obrigatório" if @params[:pickup_address_id].blank?
      errors << "Endereço de entrega é obrigatório" if @params[:delivery_address_id].blank?
      errors << "Método de pagamento é obrigatório" if @params[:payment_method].blank?
      errors << "Quantidade deve ser maior que zero" if @params[:quantity].to_i <= 0
      
      raise ArgumentError, errors.join(", ") if errors.any?
    end
  end
end
