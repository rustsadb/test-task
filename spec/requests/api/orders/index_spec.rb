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
          # Выведутся все блюда и количество заказов по каждому
          expect(response_body.size).to eq Dish.all.count
          expect(response_body.first['name']).to eq dish1.name
          expect(response_body.first['count']).to eq dish1.orders.count # 3 заказа
          expect(response_body.second['name']).to eq dish2.name
          expect(response_body.second['count']).to eq dish2.orders.count # 2 заказа
          expect(response_body.third['name']).to eq dish3.name
          expect(response_body.third['count']).to eq dish3.orders.count # 1 заказа
          # Все остальные отображаются с 0 количеством
          expect(response_body[3..].all? { |dish| dish['count'] == 0 }).to eq true
        end
      end
    end
  end
end
