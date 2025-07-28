module AddressManager
  class Updater
    attr_reader :user, :address, :address_params

    def initialize(user, address, address_params)
      @user = user
      @address = address
      @address_params = address_params
    end

    def call
      if address_belongs_to_user?
        update_address
      else
        response_error("Endereço não pertence ao usuário.")
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def address_belongs_to_user?
      @user.addresses.exists?(id: @address.id)
    end

    def update_address
      if @address.update(@address_params)
        response(@address)
      else
        response_error(@address.errors.full_messages.join(", "))
      end
    end

    def response(data)
      { success: true, message: "Endereço atualizado com sucesso.", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end
  end
end
