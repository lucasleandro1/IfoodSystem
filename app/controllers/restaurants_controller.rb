class RestaurantsController < ApplicationController
  def index
    @restaurants = User.where(role: :restaurant)
  end

  def show
    @restaurant = User.find(params[:id])
    @foods = @restaurant.foods
  end
end
