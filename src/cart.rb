# frozen_string_literal: true

class Cart
  attr_reader :products

  def initialize
    @products = []
  end

  def add_product(product)
    @tax_calculator = TaxCalculator.for(product)

    product.tax_amount = @tax_calculator.tax_value
    @products << product
  end

  def clear
    @products.clear
  end
end
