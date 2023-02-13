# frozen_string_literal: true

module Orders
  class Create < ApplicationService
    param :excluded_ingredients

    def call
      excluded_ingredients_ids = Ingredient.where(name: excluded_ingredients).pluck(:id)
      dishes_to_order_ids = Dish.dishes_to_order(excluded_ingredients_ids)
      order = Order.create(excluded_ingredients: excluded_ingredients_ids)
      create_array = dishes_to_order_ids.map do |dish_id|
        { order_id: order.id, dish_id: }
      end

      DishOrder.create(create_array)
    end
  end
end
