class DropOrderFoodsTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :order_foods
  end

  def down
    create_table :order_foods do |t|
      t.integer :order_id, null: false
      t.integer :food_id, null: false
      t.integer :quantity
      t.decimal :unit_price
      t.timestamps
    end

    add_index :order_foods, :order_id
    add_index :order_foods, :food_id
    add_foreign_key :order_foods, :orders
    add_foreign_key :order_foods, :foods
  end
end
