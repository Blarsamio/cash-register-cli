# spec/cash_register_spec.rb
require_relative '../app/cash_register'  # Adjust the path as necessary to include your CashRegister class code
require_relative '../app/product'        # Adjust the path as necessary to include your Product class code

RSpec.describe CashRegister do
  before :each do
    @products = [
      Product.new('GR1', 'Green Tea', 3.11),
      Product.new('SR1', 'Strawberries', 5.00),
      Product.new('CF1', 'Coffee', 11.23)
    ]
    @register = CashRegister.new(@products)
  end

  describe '#total_price' do
    it 'calculates the total for 2 Green Teas (GR1, GR1) correctly' do
      2.times { @register.add_product_by_code('GR1', 1) }
      expect(@register.total_price).to eq(3.11)
    end

    it 'calculates the total for 3 Strawberries and 1 Green Tea (SR1, SR1, GR1, SR1) correctly' do
      3.times { @register.add_product_by_code('SR1', 1) }
      @register.add_product_by_code('GR1', 1)
      expect(@register.total_price).to eq(16.61)
    end

    it 'calculates the total for 1 Green Tea, 1 Coffee, 1 Strawberry, and 2 more Coffees (GR1, CF1, SR1, CF1, CF1) correctly' do
      @register.add_product_by_code('GR1', 1)
      3.times { @register.add_product_by_code('CF1', 1) }
      @register.add_product_by_code('SR1', 1)
      expect(@register.total_price).to eq(30.57)
    end
  end

  describe '#remove_product_by_code' do
    it 'displays an error message when trying to remove more items than are in the cart' do
      @register.add_product_by_code('GR1', 1) # Add one Green Tea
      expect {
        @register.remove_product_by_code('GR1', 2) # Attempt to remove two
      }.to output("Not enough Green Teas in the cart.\n").to_stdout
    end
  end
end
