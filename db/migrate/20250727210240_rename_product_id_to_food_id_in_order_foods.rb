class RenameProductIdToFoodIdInOrderFoods < ActiveRecord::Migration[8.0]
  def change
    rename_column :order_foods, :product_id, :food_id
  end
end
