# frozen_string_literal: true

class CreateIngredientsAndDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.timestamps
    end

    create_table :dishes do |t|
      t.string :name
      t.timestamps
    end

    create_table :dish_ingredients do |t|
      t.references :dish
      t.references :ingredient
      t.timestamps
    end
  end
end
