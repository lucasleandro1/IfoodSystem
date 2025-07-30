class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.new
  end

  def create
    address_manager = AddressManager::Creator.new(current_user, address_params)
    result = address_manager.call
    if result[:success]
      redirect_to edit_user_registration_path, notice: result[:message]
    else
      @address = current_user.addresses.new(address_params)
      flash.now[:alert] = result[:error_message]
      render :new
    end
  end

  def edit
    @address = current_user.addresses.find(params[:id])
  end

  def update
    @address = current_user.addresses.find(params[:id])
    address_manager = AddressManager::Updater.new(current_user, @address, address_params)
    result = address_manager.call

    if result[:success]
      redirect_to edit_user_registration_path, notice: result[:message]
    else
      flash.now[:alert] = result[:error_message]
      render :edit
    end
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    address_manager = AddressManager::Destroyer.new(current_user, @address)
    result = address_manager.call

    if result[:success]
      redirect_to edit_user_registration_path, notice: result[:message]
    else
      flash[:alert] = result[:error_message]
      redirect_to edit_user_registration_path
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :number, :neighborhood)
  end
end
