class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { client: 0, restaurant: 1 }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :client
  end

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
end
