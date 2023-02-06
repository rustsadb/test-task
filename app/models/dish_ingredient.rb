# frozen_string_literal: true

class DishIngredient < ActiveRecord::Base
  belongs_to :dish
  belongs_to :ingredient
end
