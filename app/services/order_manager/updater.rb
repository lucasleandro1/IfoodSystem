module OrderManager
  class Updater
    def initialize(user:, order:, status_param:)
      @user = user
      @order = order
      @status = status_param
    end

    def call
      return false unless authorized?

      if cancel_request?
        @order.update(status: :cancelado)
      else
        @order.update(status: @status)
      end
    end

    private

    def authorized?
      return true if @user.restaurante? && @order.food.user_id == @user.id
      return true if @user.cliente? && @order.user_id == @user.id && @order.pendente?

      false
    end

    def cancel_request?
      @status == "cancelado"
    end
  end
end
