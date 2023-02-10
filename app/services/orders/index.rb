# frozen_string_literal: true

module Orders
  class Index < ApplicationService
    def call
      Dish.left_joins(:dish_orders)
          .group(:name)
          .select('dishes.name, count(dish_orders.id) as count')
          .order('count desc')
    end
  end
end
