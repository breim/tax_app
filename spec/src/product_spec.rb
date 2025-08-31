# frozen_string_literal: true

require './src/product'

RSpec.describe Product do
  describe '#initialize' do
    it 'creates a product with name and price' do
      product = Product.new(name: 'Laptop', price: 999.99, category: 'food', imported: false)
      expect(product).to be_a(Product)
      expect(product.name).to eq('Laptop')
      expect(product.price).to eq(999.99)
      expect(product.category).to eq('food')
    end

    it 'raises error when params are missing' do
      expect { Product.new }.to raise_error(ArgumentError)
      expect { Product.new('Batman Lego') }.to raise_error(ArgumentError)
    end
  end
end
