# frozen_string_literal: true

class Dish < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients

  has_many :dish_orders, dependent: :destroy
  has_many :orders, through: :dish_orders

  def self.dishes_to_order(excluded_ingredients_ids)
    where.not(
      id: joins(dish_ingredients: :ingredient)
          .where(ingredients: { id: excluded_ingredients_ids })
          .pluck(:id)
    ).pluck(:id)
  end
end
