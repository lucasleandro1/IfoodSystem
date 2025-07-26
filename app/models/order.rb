class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pickup_address, class_name: "Address"
  belongs_to :delivery_address, class_name: "Address"

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  enum :status, { cart: 0, confirmed: 1, delivered: 2 }
  enum :payment_method, { pix: 0, card: 1, cash: 2 }

  validates :estimated_value, numericality: { greater_than: 0 }
  validates :pickup_address, :delivery_address, :user, presence: true

  def total_price
    order_products.sum("quantity * unit_price")
  end
end
