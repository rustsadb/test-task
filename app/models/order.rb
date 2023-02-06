# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :dish_orders, dependent: :destroy
  has_many :dishes, through: :dish_orders
end
