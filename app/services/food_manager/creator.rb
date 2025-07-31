module FoodManager
  class Creator
    attr_reader :user, :food_params

    def initialize(user, food_params)
      @user = user
      @food_params = food_params
    end

    def call
      food = @user.foods.build(@food_params)
      if food.save
        response(food, "Produto criado com sucesso.")
      else
        response_error(food.errors.full_messages.join(", "))
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
