# frozen_string_literal: true

class ApplicationService
  extend Dry::Initializer

  class << self
    ruby2_keywords def call(*args)
      new(*args).call
    end
  end
end
