class RenameProductsToFoods < ActiveRecord::Migration[8.0]
  def change
    rename_table :products, :foods
  end
end
