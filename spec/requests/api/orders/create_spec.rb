# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/orders', type: :request do
  path '/api/orders' do
    post 'Create order by excluded ingredients' do
      tags 'Orders'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          excluded_ingredients: { type: :array, example: %w[тунец курага] }
        },
        required: %i[excluded_ingredients]
      }

      response '200', 'order created' do
        let(:data) { { excluded_ingredients: %w[тунец курага ваниль] } }
        let!(:dishes_without_ingredients_count) do
          yaml_data = YAML.load_file('db/menu.yml').deep_symbolize_keys
          count = 0
          yaml_data[:dishes].each do |d|
            count += 1 if (d[:ingredients] & data[:excluded_ingredients]).blank?
          end

          count
        end

        run_test! do |_response|
          expect(Order.count).to eq 1
          expect(Order.first.dishes.count).to eq dishes_without_ingredients_count
        end
      end

      response '200', 'created order with all dishes' do
        let(:data) { { excluded_ingredients: [] } }
        let!(:all_dishes_count) do
          yaml_data = YAML.load_file('db/menu.yml').deep_symbolize_keys
          yaml_data[:dishes].size
        end

        run_test! do |_response|
          expect(Order.count).to eq 1
          expect(Order.first.dishes.count).to eq all_dishes_count
        end
      end

      response '422', 'invalid parameter' do
        let(:data) { { excluded_ingredients: 123 } }

        run_test! do |_response|
          expect(response_errors['title']).to eq 'Unprocesable entity'
        end
      end
    end
  end
end
