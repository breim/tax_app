# frozen_string_literal: true

class Product
  attr_reader :name, :price, :category, :imported

  def initialize(name:, price:, category:, imported:)
    @name = name
    @price = price
    @category = category
    @imported = imported
  end
end
