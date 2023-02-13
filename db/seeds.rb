# frozen_string_literal: true

require 'yaml'

data = YAML.load_file('db/menu.yml').deep_symbolize_keys
data[:dishes].each do |d|
  d[:ingredients].each do |i|
    dish = Dish.find_or_create_by(name: d[:name])
    ingredient = Ingredient.find_or_create_by(name: i)
    DishIngredient.find_or_create_by(dish:, ingredient:)
  end
end

# Перестройка заказов в случае изменения ингридиентов или блюд
Order.all.each do |order|
  # Определяем подходящие блюда для заказа заново
  dishes_to_order_ids = Dish.dishes_to_order(order.excluded_ingredients)
  # Имеющиеся блюда у заказа
  existing_dishes_ids = order.dishes.pluck(:id)

  # Находим блюда котороые надо удалить из заказа и добавить в заказ
  dishes_to_delete_ids = existing_dishes_ids - dishes_to_order_ids
  dishes_to_create_ids = dishes_to_order_ids - existing_dishes_ids

  # Переходим к следующему заказу если ничего не надо менять
  next if dishes_to_delete_ids.empty? && dishes_to_create_ids.empty?

  # Удаляем из заказа блюда
  order.dish_orders.where(dish_id: dishes_to_delete_ids).destroy_all if dishes_to_delete_ids.present?

  # Добавляем блюда в заказ если нужно
  next unless dishes_to_create_ids.present?

  create_array = dishes_to_create_ids.map do |dish_id|
    { order_id: order.id, dish_id: }
  end

  DishOrder.create!(create_array)
end
