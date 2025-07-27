class RenameOrderProductsToOrderFoods < ActiveRecord::Migration[8.0]
  def change
    rename_table :order_products, :order_foods
  end
end
