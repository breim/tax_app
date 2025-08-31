# frozen_string_literal: true

require './src/cart'
require './src/product'

RSpec.describe Cart do
  subject(:cart) { described_class.new }

  let(:book) { Product.new(name: 'Book', price: 999.99, category: 'food', imported: false) }
  let(:phone) { Product.new(name: 'Phone', price: 499.99, category: 'food', imported: false) }
  let(:taxable_product) { Product.new(name: 'Laptop', price: 1000, category: 'eletronic', imported: false) }

  describe '#initialize' do
    it 'initializes with an empty products array' do
      expect(cart).to be_a(Cart)
      expect(cart.products).to be_empty
    end
  end

  describe '#add_product' do
    context 'when adding a single product' do
      it 'includes the product in the cart' do
        cart.add_product(book)

        expect(cart.products).to include(book)
      end
    end

    context 'when adding a taxable product' do
      it 'calculates and assigns tax amount to the product' do
        cart.add_product(taxable_product)

        expect(cart.products.first.tax_amount).to eq(100)
      end
    end
  end

  describe '#clear' do
    it 'removes all products from the cart' do
      cart.add_product(book)
      cart.add_product(phone)
      cart.clear

      expect(cart.products).to be_empty
    end
  end
end
