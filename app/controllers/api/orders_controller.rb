# frozen_string_literal: true

module Api
  class OrdersController < ApplicationController
    def create
      valid_params = validate_with(Orders::CreateForm, params)
      Orders::Create.(valid_params[:excluded_ingredients])

      render_ok
    end

    def index
      result = Orders::Index.call

      render_result(result, Orders::IndexBlueprint)
    end
  end
end
