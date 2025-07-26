class Address < ApplicationRecord
  belongs_to :user

  validates :street, :number, :neighborhood, presence: true
end
