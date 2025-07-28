class Food < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :name, :price, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
