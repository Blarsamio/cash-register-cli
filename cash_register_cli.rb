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
    total = cart.sum(&:price)
    puts "Total Price: $#{format('%.2f', total)}"
    total
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
