class Order < ApplicationRecord
  belongs_to :user
  belongs_to :food
  belongs_to :pickup_address, class_name: "Address"
  belongs_to :delivery_address, class_name: "Address"

  enum :status, { pendent: 0, preparing: 1, in_route: 2, delivered: 3 }
  enum :payment_method, { pix: 0, card: 1, cash: 2 }

  validates :payment_method, presence: true
  validates :estimated_value, numericality: { greater_than: 0 }
  validates :pickup_address, :delivery_address, :user, presence: true
end
