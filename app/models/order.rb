class Order < ApplicationRecord
  belongs_to :user
  belongs_to :food
  belongs_to :pickup_address, class_name: "Address"
  belongs_to :delivery_address, class_name: "Address"

  enum :status, { pendente: 0, cancelado: 1, preparando: 2, em_rota: 3, entregue: 4 }
  enum :payment_method, { pix: 0, card: 1, cash: 2 }

  validates :payment_method, presence: true
  validates :estimated_value, numericality: { greater_than: 0 }
  validates :pickup_address, :delivery_address, :user, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "estimated_value", "food_id", "id", "payment_method", "requested_at",
     "status", "updated_at", "user_id", "pickup_address_id", "delivery_address_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "food", "pickup_address", "delivery_address" ]
  end
end
