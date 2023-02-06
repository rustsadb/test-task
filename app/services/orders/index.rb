# frozen_string_literal: true

module Orders
  class Index < ApplicationService
    def call
      Dish.joins(:dish_orders)
          .group(:name)
          .select('dishes.name, count(*) as count')
          .order('count desc')
    end
  end
end
