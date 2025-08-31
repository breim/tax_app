# frozen_string_literal: true

require './src/cart'
require './src/product'

RSpec.describe Cart do
  let(:subject) { described_class.new }

  describe '#initialize' do
    it 'creates a cart with an empty products array' do
      expect(subject).to be_a(Cart)
      expect(subject.products).to eq([])
    end
  end

  describe '#add_product' do
    it 'adds a product to the cart' do
      product = Product.new(name: 'Laptop', price: 999.99, category: 'food', imported: false)
      subject.add_product(product)
      expect(subject.products).to include(product)
    end
  end

  describe '#clear' do
    it 'clears all products from the cart' do
      product1 = Product.new(name: 'Laptop', price: 999.99, category: 'food', imported: false)
      product2 = Product.new(name: 'Phone', price: 499.99, category: 'food', imported: false)
      subject.add_product(product1)
      subject.add_product(product2)
      subject.clear
      expect(subject.products).to eq([])
    end
  end
end
