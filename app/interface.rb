require_relative 'cash_register'
require_relative 'product'

PRODUCTS = [
  Product.new('GR1', 'Green Tea', 3.11),
  Product.new('SR1', 'Strawberries', 5.00),
  Product.new('CF1', 'Coffee', 11.23)
].freeze

def main_menu
  puts "\n*** Main Menu ***"
  puts '1. View Products'
  puts '2. Add Product to Cart'
  puts '3. Remove Product from Cart'
  puts '4. View Cart'
  puts '5. Checkout'
  puts '6. Exit'
  puts 'Enter your choice:'
  gets.strip.to_i
end

def display_products(products)
  puts "\n*** Products ***"
  products.each do |product|
    puts "#{product.code} - #{product.name} - $#{format('%.2f', product.price)}"
  end
end

def display_cart(cart)
  puts "\n*** Cart ***"
  cart.each do |product|
    puts "#{product.code} - #{product.name} - $#{format('%.2f', product.price)}"
  end
end

def add_product_to_cart(cash_register)
  display_products(PRODUCTS)
  puts "\nEnter the product code you wish to add:"
  code = gets.strip.upcase
  puts 'Enter the quantity:'
  quantity = gets.strip.to_i
  cash_register.add_product_by_code(code, quantity)
end

def remove_product_from_cart(cash_register)
  display_cart(cash_register.cart)
  puts "\nEnter the product code you wish to remove:"
  code = gets.strip.upcase
  puts 'Enter the quantity:'
  quantity = gets.strip.to_i
  cash_register.remove_product_by_code(code, quantity)
end

def checkout(cash_register)
  puts "\nFinalizing your purchase..."
  cash_register.total_price
end

def start_cash_register
  cash_register = CashRegister.new(PRODUCTS)
  loop do
    case main_menu
    when 1
      display_products(PRODUCTS)
    when 2
      add_product_to_cart(cash_register)
    when 3
      remove_product_from_cart(cash_register)
    when 4
      display_cart(cash_register.cart)
    when 5
      checkout(cash_register)
      break
    when 6
      puts 'Exiting...'
      break
    else
      puts 'Invalid option. Please try again.'
    end
  end
end

start_cash_register
