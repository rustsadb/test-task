# frozen_string_literal: true

module Orders
  class Create < ApplicationService
    param :excluded_ingredients

    def call
      excluded_dishes_ids = Dish.joins(dish_ingredients: :ingredient)
                                .where('ingredients.name in (?)', excluded_ingredients)
                                .pluck(:id)
      dishes_to_order_ids = Dish.where.not(id: excluded_dishes_ids.uniq).pluck(:id)
      order = Order.create
      create_array = dishes_to_order_ids.map do |dish_id|
        { order_id: order.id, dish_id: }
      end

      DishOrder.create(create_array)
    end
  end
end
