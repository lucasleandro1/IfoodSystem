class RestaurantsController < ApplicationController
  def index
    @restaurants = User.where(role: :restaurant)
  end

  def show
    @restaurant = User.find(params[:id])
    @products = @restaurant.products
  end
end
