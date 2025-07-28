class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to root_path, notice: "Endereço cadastrado com sucesso."
    else
      render :new
    end
  end

  def edit
    @address = current_user.addresses.find(params[:id])
  end

  def update
    @address = current_user.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to edit_user_registration_path, notice: "Endereço atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    @address.destroy
    redirect_to edit_user_registration_path, notice: "Endereço excluído com sucesso."
  end

  private

  def address_params
    params.require(:address).permit(:street, :number, :neighborhood)
  end
end
