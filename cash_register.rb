# frozen_string_literal: true

# CashRegister class
class CashRegister
  attr_accessor :products, :cart

  def initialize(products)
    @products = products
    @cart = []
  end

  def add_product_by_code(code, quantity)
    product = products.find { |p| p.code == code }
    if product
      add_product_to_cart(product, quantity)
    else
      puts "Product code #{code} not found."
    end
  end

  def total_price
    total = 0
    summary = cart.group_by(&:code).map do |code, items|
      apply_discounts(code, items)
    end
    summary.each { |item| total += item[:total] }
    puts "Total Price: $#{format('%.2f', total)}"
    total
  end

  private

  def add_product_to_cart(product, quantity)
    quantity.times { cart << product }
    if quantity > 1
      puts "#{quantity} #{product.name}s added. Price: $#{format('%.2f', product.price)}"
    else
      puts "#{product.name} added. Price: $#{format('%.2f', product.price)}"
    end
  end

  def apply_discounts(code, items)
    case code
    when 'GR1'
      apply_green_tea_discount(items)
    when 'SR1'
      apply_strawberries_discount(items)
    when 'CF1'
      apply_coffee_discount(items)
    else
      { name: items.first.name, quantity: quantity, total: total_price }
    end
  end

  def apply_green_tea_discount(items)
    quantity = items.count
    price_per_item = items.first.price
    paid_items = (quantity + 1) / 2
    total_price = paid_items * price_per_item
    puts "Buy-one-get-one-free on Green Tea: #{quantity} for $#{format('%.2f', total_price)}"
    { name: 'Green Tea', quantity: quantity, total: total_price }
  end

  def apply_strawberries_discount(items)
    quantity = items.count
    price_per_item = quantity >= 3 ? 4.50 : items.first.price
    total_price = quantity * price_per_item
    puts "Discount on Strawberries if 3 or more: #{quantity} for $#{format('%.2f', price_per_item)} instead of $5.00"
    { name: 'Strawberries', quantity: quantity, total: total_price }
  end

  def apply_coffee_discount(items)
    quantity = items.count
    price_per_item = quantity >= 3 ? (items.first.price * 2 / 3) : items.first.price
    total_price = quantity * price_per_item
    puts "Discount on Coffee if 3 or more: #{quantity} for $#{format('%.2f', price_per_item)} instead of $11.23"
    { name: 'Coffee', quantity: quantity, total: total_price }
  end
end
