# Product class
class Product
  attr_accessor :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price.to_f
  end
end

# CashRegister class
class CashRegister
  attr_accessor :products, :cart

  def initialize(products)
    @products = products
    @cart = []
  end

  def add_product_by_code(code)
    product = products.find { |p| p.code == code }
    if product
      cart << product
      puts "#{product.name} added. Price: $#{format('%.2f', product.price)}"
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
    price_per_item = items.first.price
    price_per_item = quantity >= 3 ? 4.50 : price_per_item
    total_price = quantity * price_per_item
    puts "Discount on Strawberries if 3 or more: #{quantity} for $#{format('%.2f', price_per_item)} instead of $5.00"
    { name: 'Strawberries', quantity: quantity, total: total_price }
  end

  def apply_coffee_discount(items)
    quantity = items.count
    price_per_item = quantity >= 3 ? (items.first.price * 2 / 3) : item
    total_price = quantity * price_per_item
    puts "Discount on Coffee if 3 or more: #{quantity} for $#{format('%.2f', price_per_item)} instead of $11.23"
    { name: 'Coffee', quantity: quantity, total: total_price }
  end
end

PRODUCTS = [
  Product.new('GR1', 'Green Tea', 3.11),
  Product.new('SR1', 'Strawberries', 5.00),
  Product.new('CF1', 'Coffee', 11.23)
]

def start_cash_register
  cash_register = CashRegister.new(PRODUCTS)
  puts 'Welcome to the Cash Register!'
  loop do
    display_products(cash_register)
    input = user_input
    break if input.downcase == 'done'

    cash_register.add_product_by_code(input.upcase)
  end
  cash_register.total_price
end

def display_products(cash_register)
  puts 'Available products:'
  cash_register.products.each do |product|
    puts "#{product.code} - #{product.name} - $#{format('%.2f', product.price)}"
  end
end

def user_input
  puts "Enter a product code to add to the cart (or type 'done' to see total):"
  gets.chomp
end

start_cash_register
