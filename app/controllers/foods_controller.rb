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
    result = FoodManager::Creator.new(current_user, food_params).call

    if result[:success]
      redirect_to foods_path, notice: result[:message]
    else
      @food = Food.new(food_params)
      flash.now[:alert] = result[:error_message]
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    result = FoodManager::Updater.new(@food, food_params).call

    if result[:success]
      redirect_to foods_path, notice: result[:message]
    else
      flash.now[:alert] = result[:error_message]
      render :edit
    end
  end

  def destroy
    result = FoodManager::Destroyer.new(@food).call

    if result[:success]
      redirect_to foods_path, notice: result[:message]
    else
      redirect_to foods_path, alert: result[:error_message]
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to foods_path, alert: "Produto não encontrado."
  end

  def require_restaurant
    redirect_to root_path, alert: "Acesso restrito." unless current_user.restaurant?
  end

  def food_params
    params.require(:food).permit(:name, :description, :price)
  end
end
