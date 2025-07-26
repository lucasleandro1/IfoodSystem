class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pickup_address, foreign_key: { to_table: :addresses }
      t.references :delivery_address, foreign_key: { to_table: :addresses }
      t.text :item_description
      t.datetime :requested_at
      t.decimal :estimated_value
      t.integer :payment_method

      t.timestamps
    end
  end
end
