# frozen_string_literal: true

module ErrorsHandlerable
  extend ActiveSupport::Concern

  included do
    rescue_from Api::UnprocessableEntity do |e|
      render json: { errors: e.error_hash }, status: :unprocessable_entity
    end
  end
end
