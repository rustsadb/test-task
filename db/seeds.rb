# frozen_string_literal: true

require 'yaml'

# data = YAML.load_file('db/menu.yml').deep_symbolize_keys
# data[:ingredients].each { |i| Ingredient.create(name: i) }
# data[:dishes].each { |d| Dish.create(name: d[:name]) }
# data[:dishes].each do |d|
#   d[:ingredients].each do |i|
#     dish = Dish.find_by_name(d[:name])
#     ingredient = Ingredient.find_by_name(i)
#     DishesIngredient.create(dishes_id: dish.id, ingredients_id: ingredient.id)
#   end
# end
data = YAML.load_file('db/menu.yml').deep_symbolize_keys
data[:dishes].each do |d|
  d[:ingredients].each do |i|
    dish = Dish.find_or_create_by(name: d[:name])
    ingredient = Ingredient.find_or_create_by(name: i)
    DishIngredient.find_or_create_by(dish:, ingredient:)
  end
end
