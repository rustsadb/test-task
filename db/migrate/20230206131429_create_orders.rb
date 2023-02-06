# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, &:timestamps

    create_table :dish_orders do |t|
      t.references :dish
      t.references :order
      t.timestamps
    end
  end
end
