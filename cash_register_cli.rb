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

def start_cash_register
  cash_register = CashRegister.new
  loop do
    puts "Enter product name (or type 'done' to calculate total):"
    name = gets.chomp
    break if name.downcase == 'done'

    puts "Enter product price(or type 'done' to calculate total):"
    price = gets.chomp.to_f
    cash_register.add_product(Product.new(name, price))
  end
  cash_register.total_price
end

start_cash_register
