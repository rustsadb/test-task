# frozen_string_literal: true

module Orders
  class IndexBlueprint < Blueprinter::Base
    fields :name, :count
  end
end
