# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/orders', type: :request do
  path '/api/orders' do
    post 'Orders by ingredients' do
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

      let(:data) { { excluded_ingredients: %w[тунец курага ваниль] } }

      response '200', 'email registered and confirmation link sended' do
        run_test! do |_response|
          expect(Order.count).to eq 1
        end
      end
    end
  end
end
