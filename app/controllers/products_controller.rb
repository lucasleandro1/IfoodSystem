class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_restaurant, only: %i[new create edit update destroy]
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = current_user.client? ? Product.all : current_user.products
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to products_path, notice: "Produto criado com sucesso!"
    else
      render :new
    end
  end

  def show
  end
  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "Produto atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Produto excluído com sucesso!"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def require_restaurant
    redirect_to root_path, alert: "Acesso restrito." unless current_user.restaurant?
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
