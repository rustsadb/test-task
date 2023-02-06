# frozen_string_literal: true

module Api
  class UnprocessableEntityExceptionError < StandardError
    attr_reader :status

    def initialize(errors)
      super
      @errors = errors
      @status = 422
    end

    def error_hash
      errors_array = @errors.map do |e|
        field = e.first
        reason = e.last
        reason = e.last.first if e.last.is_a?(Array)
        reason = e.last[e.last.keys.first].first if e.last.is_a?(Hash)

        {
          title: I18n.t('api.errors.unprocessable_entity_exception'),
          status: @status,
          source: { pointer: "data/attributes/#{field}" },
          detail: reason
        }
      end

      errors_array.first
    end
  end
end
