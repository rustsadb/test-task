# frozen_string_literal: true

module DryValidatable
  extend ActiveSupport::Concern

  def validate_with(form, params, key = nil)
    params = params.to_unsafe_h unless params.is_a?(Hash)

    validation_result = form.new.call(params[key] || params)

    raise Api::UnprocessableEntity, validation_result.errors.to_h unless validation_result.success?

    validation_result.to_h
  end
end
