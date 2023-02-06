# frozen_string_literal: true

class Dish < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients

  has_many :dish_orders, dependent: :destroy
  has_many :orders, through: :dish_orders
end
