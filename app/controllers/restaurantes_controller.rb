class RestaurantesController < ApplicationController
  def index
    @restaurantes = User.where(role: :restaurante)
  end

  def show
    @restaurante = User.find(params[:id])
    @foods = @restaurante.foods
  end
end
