class Food < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :name, :price, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "name", "price", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "orders" ]
  end
end
