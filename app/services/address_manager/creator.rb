
module AddressManager
  class Creator
    attr_reader :user, :address_params

    def initialize(user, address_params)
      @user = user
      @address_params = address_params
    end

    def call
      if address_exists?
        response_error("Endereço já existe para o usuário.")
      else
        create_address
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def address_exists?
      @user.addresses.exists?(street: @address_params[:street], number: @address_params[:number], neighborhood: @address_params[:neighborhood])
    end

    def create_address
      address = @user.addresses.create(@address_params)
      if address.persisted?
        response(address)
      else
        response_error(address.errors.full_messages.join(", "))
      end
    end

    def response(data)
      { success: true, message: "Endereço cadastrado com sucesso.", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end
  end
end
