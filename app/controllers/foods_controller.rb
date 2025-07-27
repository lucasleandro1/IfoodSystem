class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_restaurant, only: %i[new create edit update destroy]
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = current_user.client? ? Food.all : current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, notice: "Produto criado com sucesso!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to foods_path, notice: "Produto atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    redirect_to foods_path, notice: "Produto excluído com sucesso!"
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def require_restaurant
    redirect_to root_path, alert: "Acesso restrito." unless current_user.restaurant?
  end

  def food_params
    params.require(:food).permit(:name, :description, :price)
  end
end
