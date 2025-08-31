# frozen_string_literal: true

class Product
  attr_reader :name, :price, :category, :imported
  attr_accessor :tax_amount, :price_with_taxes

  def initialize(name:, price:, category:, imported:)
    @name = name
    @price = price
    @category = category
    @imported = imported
    @tax_amount = 0
    @price_with_taxes = 0
  end
end
