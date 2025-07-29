class RestaurantesController < ApplicationController
  def index
    @restaurantes = User.where(role: :restaurante).page(params[:page]).per(9)
  end

  def show
    @restaurante = User.find(params[:id])
    @foods = @restaurante.foods
  end
end
