# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, &:timestamps

    create_table :dish_orders do |t|
      t.references :dish
      t.references :order
      t.timestamps
    end

    add_index :dish_ingredients, %i[dish_id ingredient_id], unique: true
  end
end
