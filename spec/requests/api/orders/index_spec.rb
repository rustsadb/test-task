# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/orders', type: :request do
  path '/api/orders' do
    get 'Get dishes name and count of all orders' do
      tags 'Orders'

      consumes 'application/json'
      produces 'application/json'

      let(:dish1) { Dish.first }
      let(:dish2) { Dish.second }
      let(:dish3) { Dish.third }

      let(:order1) { Order.create }
      let(:order2) { Order.create }
      let(:order3) { Order.create }

      let!(:dish_order1) { DishOrder.create(order: order1, dish: dish1) }
      let!(:dish_order2) { DishOrder.create(order: order2, dish: dish1) }
      let!(:dish_order3) { DishOrder.create(order: order2, dish: dish2) }
      let!(:dish_order4) { DishOrder.create(order: order3, dish: dish1) }
      let!(:dish_order5) { DishOrder.create(order: order3, dish: dish2) }
      let!(:dish_order6) { DishOrder.create(order: order3, dish: dish3) }

      response '200', 'dish name and count showed' do
        run_test! do |_response|
          expect(response_body.pluck('name')).to eq [dish1, dish2, dish3].map(&:name)
          expect(response_body.pluck('count')).to eq([dish1, dish2, dish3].map { |d| d.dish_orders.count })
        end
      end
    end
  end
end
