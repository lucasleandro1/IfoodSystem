# app/services/food_manager/destroyer.rb
module FoodManager
  class Destroyer
    attr_reader :food

    def initialize(food)
      @food = food
    end

    def call
      if @food.destroy
        response("Produto excluído com sucesso.")
      else
        response_error("Erro ao excluir o produto.")
      end
    rescue StandardError => e
      response_error(e.message)
    end

    private

    def response(message)
      { success: true, message: }
    end

    def response_error(error)
      { success: false, error_message: error }
    end
  end
end
