class AddFoodToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :food, null: false, foreign_key: true
  end
end
