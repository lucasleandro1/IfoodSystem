module AddressManager
  class Destroyer
    attr_reader :user, :address

    def initialize(user, address)
      @user = user
      @address = address
    end

    def call
      if address_belongs_to_user?
        destroy_address
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

    def destroy_address
      @address.destroy
      response(@address)
    end

    def response(data)
      { success: true, message: "Endereço excluído com sucesso.", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end
  end
end
