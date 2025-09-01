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
end
