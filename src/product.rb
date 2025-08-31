# frozen_string_literal: true

class Product
  attr_reader :name, :price, :category

  def initialize(name, price, category)
    @name = name
    @price = price
    @category = category
  end
end
