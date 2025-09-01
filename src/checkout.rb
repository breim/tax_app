# frozen_string_literal: true

require './src/cart'

class Checkout
  attr_reader :cart

  def initialize
    @cart = Cart.new
  end

  def total_with_taxes
    @cart.products.sum { |product| product&.price_with_taxes }
  end

  def total_taxes_value
    @cart.products.sum { |product| product&.tax_amount }
  end

  def grouped_receipt
    grouped_products = @cart.products.group_by { |product| product&.name }

    grouped_products.map do |name, products|
      total_quantity = products.count
      total_value = products.sum { |product| product&.price_with_taxes }
      "#{total_quantity} #{name}: #{format('%.2f', total_value)}"
    end.join("\n")
  end
end
