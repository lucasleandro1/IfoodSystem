class Address < ApplicationRecord
  belongs_to :user

  has_many :pickup_orders, class_name: "Order", foreign_key: "pickup_address_id", dependent: :destroy
  has_many :delivery_orders, class_name: "Order", foreign_key: "delivery_address_id", dependent: :destroy
  validates :street, :number, :neighborhood, presence: true
end
