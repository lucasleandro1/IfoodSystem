
module FoodManager
  class Updater
    attr_reader :food, :food_params

    def initialize(food, food_params)
      @food = food
      @food_params = food_params
    end

    def call
      if @food.update(@food_params)
        response(@food, "Produto atualizado com sucesso.")
      else
        response_error(@food.errors.full_messages.join(", "))
      end
    rescue StandardError => e
      response_error(e.message)
    end

    private

    def response(data, message)
      { success: true, message:, resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end
  end
end
