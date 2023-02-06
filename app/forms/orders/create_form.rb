# frozen_string_literal: true

module Orders
  class CreateForm < ApplicationForm
    params do
      required(:excluded_ingredients).value(:array).each(:string)
    end
  end
end
