# frozen_string_literal: true

class AddExcludedIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :excluded_ingredients, :text, array: true, default: []
  end
end
