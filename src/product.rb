# frozen_string_literal: true

class Product
  attr_reader :name, :price, :category, :imported
  attr_accessor :tax_amount

  def initialize(name:, price:, category:, imported:, tax_amount: 0)
    @name = name
    @price = price
    @category = category
    @imported = imported
    @tax_amount = tax_amount
  end
end
