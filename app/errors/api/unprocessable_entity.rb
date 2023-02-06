# frozen_string_literal: true

module Api
  class UnprocessableEntity < StandardError
    def initialize(errors)
      super
      @errors = errors
      @status = 422
      @title = 'Unprocesable entity'
    end

    def error_hash
      {
        title: @title,
        status: @status,
        detail: @errors
      }
    end
  end
end
