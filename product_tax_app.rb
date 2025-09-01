# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize

require './src/tax_calculator'
require './src/checkout'
require './src/text_parser'

class ProductTaxApp
  def initialize
    @checkout = Checkout.new
  end

  def run
    puts '=== ProductTaxApp ==='
    puts "Enter items in the format: 'quantity item at price'"
    puts "Example: '2 book at 12.49' or '1 imported bottle of perfume at 47.50'"
    puts "Type 'total' to see the final receipt"
    puts "Type 'clear' to empty the cart"
    puts "Type 'exit' to quit"
    puts '=' * 20

    loop do
      print '> '
      input = gets.chomp.strip

      case input.downcase
      when 'total'
        show_receipt
      when 'clear'
        clear_cart
      when 'exit', 'quit'
        puts 'Thanks!'
        break
      when ''
        next
      else
        add_product(input)
      end
    end
  end

  private

  def add_product(input)
    parsed = TextParser.parse(input)

    if parsed
      product = parsed[:product]
      quantity = parsed[:quantity]

      quantity.times do
        @checkout.cart.add_product(product)
      end

      puts "Added: #{quantity} #{product.name} - $#{product.price}"
    else
      puts "Invalid format. Use: 'quantity item at price'"
      puts "Example: '2 book at 12.49'"
    end
  end

  def show_receipt
    return puts 'Cart is empty!' if @checkout.cart.products.empty?

    puts "\n#{'=' * 30}"
    puts 'RECEIPT'
    puts '=' * 30
    puts @checkout.grouped_receipt
    puts '-' * 30
    puts "Sales Taxes: #{format('%.2f', @checkout.total_taxes_value)}"
    puts "Total: #{format('%.2f', @checkout.total_with_taxes)}"
    puts "#{'=' * 30}\n"
  end

  def clear_cart
    @checkout.cart.clear
    puts 'Cart cleared!'
  end
end

if __FILE__ == $PROGRAM_NAME
  app = ProductTaxApp.new
  app.run
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
