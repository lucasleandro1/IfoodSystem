class HomeController < ApplicationController
  def index
    if current_user&.restaurante?
      redirect_to orders_path
      return
    end

    result = FoodFilterService.call(params)
    @foods = result[:foods]
    @q = result[:search]
    @restaurants = result[:restaurants]
  end
end
