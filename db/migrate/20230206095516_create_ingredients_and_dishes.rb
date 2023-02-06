# frozen_string_literal: true

class CreateIngredientsAndDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :dishes do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :dish_ingredients do |t|
      t.references :dish
      t.references :ingredient
      t.timestamps
    end

    add_index :ingredients, :name, unique: true
    add_index :dishes, :name, unique: true
    add_index :dish_ingredients, %i[dish_id ingredient_id], unique: true
  end
end
