class OrderFood < ApplicationRecord
  belongs_to :order
  belongs_to :food

  validates :quantity, :unit_price, presence: true
end
