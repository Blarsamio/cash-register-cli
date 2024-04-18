# frozen_string_literal: true

require_relative 'cash_register'
require_relative 'product'

PRODUCTS = [
  Product.new('GR1', 'Green Tea', 3.11),
  Product.new('SR1', 'Strawberries', 5.00),
  Product.new('CF1', 'Coffee', 11.23)
].freeze

def start_cash_register
  cash_register = CashRegister.new(PRODUCTS)
  puts 'Welcome to the Cash Register!'
  loop do
    display_products(cash_register)
    input = user_input
    break if input.downcase == 'done'

    process_product(cash_register, input)
  end

  cash_register.total_price
end

def process_product(cash_register, input)
  puts "Enter the quantity for #{input}:"
  quantity = gets.strip.to_i
  cash_register.add_product_by_code(input, quantity)
end

def display_products(cash_register)
  puts 'Available products: '
  cash_register.products.each do |product|
    puts "#{product.code} - #{product.name} - $#{format('%.2f', product.price)}"
  end
end

def user_input
  puts "Enter a product code to add to the cart (or type 'done' to see total):"
  gets.strip.upcase
end

start_cash_register
