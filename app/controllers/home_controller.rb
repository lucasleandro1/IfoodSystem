class HomeController < ApplicationController
  def index
    if current_user&.restaurante?
      redirect_to orders_path
      return
    end

    @foods = Food.joins(:user).includes(:user)

    case params[:sort_by]
    when "price_asc"
      @foods = @foods.order("foods.price ASC")
    when "price_desc"
      @foods = @foods.order("foods.price DESC")
    when "name"
      @foods = @foods.order("foods.name ASC")
    when "restaurante"
      @foods = @foods.joins(:user).order("users.email ASC")
    else
      @foods = @foods.order("foods.created_at DESC")
    end

    @foods = @foods.page(params[:page]).per(8)
  end
end
