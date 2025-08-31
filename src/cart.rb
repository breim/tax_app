# frozen_string_literal: true

class Cart
  attr_reader :products

  def initialize
    @products = []
  end

  def add_product(product)
    @tax_calculator = TaxCalculator.for(product)

    product.price_with_taxes = @tax_calculator.price_with_taxes
    product.tax_amount = @tax_calculator.tax_amount
    @products << product
  end

  def clear
    @products.clear
  end
end
