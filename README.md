# Cash Register CLI

## Description

The CLI Cash Register is a simple command-line application designed to simulate a basic retail checkout system. 
It allows users to add products with specified quantities to a shopping cart and calculates the total cost considering applicable discounts and offers.

## Installation

To run the CLI Cash Register, follow these steps:

1. Clone the repository:
   
   gh repo clone Blarsamio/cash-register-cli

   cd cash-register-cli

2. Ensure Ruby is properly installed. This application was built with Ruby 3.1.2 You can check your Ruby version using:
   
   ruby -v

3. Install required gems:
   
   bundle install


# Usage

1. To start the application, run the following command in the terminal:
   
   ruby app/cash_register.rb

Follow the prompts to select from the different options such as displaying products, adding them to the cart or removing them from the cart.

Select "Checkout" options when you're finished to see the total with discounts or promotions.

# Testing

1. For testing, this application uses Rspec, run the following command in the terminal: 

   rspec spec/cash_register_spec.rb


# Features

Product Management: Add products with unique codes and prices.
Special Offers: Apply discounts like buy-one-get-one-free for selected items.
Flexible Pricing: Adjust pricing based on the quantity of items purchased.

# Contact

Patricio Pérez Herrero – patriciopherrero@gmail.com

Project Link: https://github.com/Blarsamio/cash-register-cli
