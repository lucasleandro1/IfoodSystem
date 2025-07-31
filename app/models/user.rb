class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { cliente: 0, restaurante: 1 }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :cliente
  end

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :foods, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "email", "id", "role", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "addresses", "orders", "foods" ]
  end
end
