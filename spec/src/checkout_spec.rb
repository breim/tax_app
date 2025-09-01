# frozen_string_literal: true

require './src/checkout'

RSpec.describe Checkout do
  let(:checkout) { described_class.new }
  let(:book) { Product.new(name: 'Harry Potter', price: 12.49, category: 'book', imported: false) }
  let(:imported_book) { Product.new(name: 'Imported Book', price: 12.49, category: 'book', imported: true) }

  describe '#initialize' do
    it 'initializes with a cart and a text parser' do
      expect(checkout.cart).to be_a(Cart)
    end
  end

  describe '#total_with_taxes' do
    it 'when the product is exempt with taxes' do
      checkout.cart.add_product(book)
      expect(checkout.total_with_taxes).to eql(12.49)
    end

    it 'when the product have taxes' do
      checkout.cart.add_product(imported_book)
      expect(checkout.total_with_taxes).to eql(13.14)
    end
  end

  describe '#total_taxes_value' do
    it 'when the product is exempt with taxes' do
      checkout.cart.add_product(book)
      expect(checkout.total_taxes_value).to eql(0.0)
    end

    it 'when the product have taxes' do
      checkout.cart.add_product(imported_book)
      expect(checkout.total_taxes_value).to eql(0.65)
    end
  end
end
