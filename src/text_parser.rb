# frozen_string_literal: true

require './src/product'

class TextParser
  def self.parse(input_text)
    name = extract_name(input_text)
    category = extract_category(input_text)
    imported = input_text.include?('imported')
    price = input_text.split.last.to_f
    quantity = input_text.split.first.to_i
    product = build_product(name, category, imported, price)

    { product: product, quantity: quantity }
  end

  def self.extract_name(input_text)
    words = input_text.split
    quantity_removed = words[1..].join(' ')
    quantity_removed.split(' at ').first.strip
  end

  def self.extract_category(input_text)
    case input_text.downcase
    when /book/
      'book'
    when /chocolate/, /bar/
      'food'
    when /pill/, /medicine/
      'medicine'
    else
      'others'
    end
  end

  def self.build_product(name, category, imported, price)
    Product.new(
      name: name,
      category: category,
      imported: imported,
      price: price
    )
  end
end
