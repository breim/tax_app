# frozen_string_literal: true

require './src/product'

RSpec.describe Product do
  describe '#initialize' do
    it 'creates a product with name and price' do
      product = Product.new('Laptop', 999.99)
      expect(product).to be_a(Product)
      expect(product.name).to eq('Laptop')
      expect(product.price).to eq(999.99)
    end

    it 'raises error when params are missing' do
      expect { Product.new }.to raise_error(ArgumentError)
    end
  end
end
