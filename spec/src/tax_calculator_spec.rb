# frozen_string_literal: true

require './src/product'
require './src/tax_calculator'

RSpec.describe TaxCalculator do
  let(:book) { Product.new(name: 'Harry Potter', price: 12.49, category: 'book', imported: false) }
  let(:imported_book) { Product.new(name: 'Imported Book', price: 10.00, category: 'book', imported: true) }
  let(:food) { Product.new(name: 'Chocolate bar', price: 0.85, category: 'food', imported: false) }
  let(:imported_food) { Product.new(name: 'Imported chocolates', price: 10.00, category: 'food', imported: true) }
  let(:medicine) { Product.new(name: 'Pills', price: 9.75, category: 'medicine', imported: false) }
  let(:toy) { Product.new(name: 'Toy car', price: 14.99, category: 'toy', imported: false) }
  let(:imported_toy) { Product.new(name: 'Imported toy', price: 27.99, category: 'toy', imported: true) }
  let(:perfume) { Product.new(name: 'Perfume', price: 18.99, category: 'perfume', imported: false) }
  let(:imported_perfume) { Product.new(name: 'Imported perfume', price: 47.50, category: 'perfume', imported: true) }

  describe '.for' do
    context 'when product is domestic and exempt' do
      it 'returns Exempt calculator for books' do
        expect(described_class.for(book)).to be_a(TaxCalculator::Exempt)
      end

      it 'returns Exempt calculator for food' do
        expect(described_class.for(food)).to be_a(TaxCalculator::Exempt)
      end

      it 'returns Exempt calculator for medicine' do
        expect(described_class.for(medicine)).to be_a(TaxCalculator::Exempt)
      end
    end

    context 'when product is imported' do
      it 'returns Imported calculator for imported books' do
        expect(described_class.for(imported_book)).to be_a(TaxCalculator::Imported)
      end

      it 'returns Imported calculator for imported toys' do
        expect(described_class.for(imported_toy)).to be_a(TaxCalculator::Imported)
      end
    end

    context 'when product is domestic and taxable' do
      it 'returns Domestic calculator for toys' do
        expect(described_class.for(toy)).to be_a(TaxCalculator::Domestic)
      end

      it 'returns Domestic calculator for perfume' do
        expect(described_class.for(perfume)).to be_a(TaxCalculator::Domestic)
      end
    end
  end

  describe '.exempt_category?' do
    it 'returns true for exempt categories' do
      expect(described_class.exempt_category?(book)).to be(true)
      expect(described_class.exempt_category?(food)).to be(true)
      expect(described_class.exempt_category?(medicine)).to be(true)
    end

    it 'returns false for non-exempt categories' do
      expect(described_class.exempt_category?(toy)).to be(false)
      expect(described_class.exempt_category?(perfume)).to be(false)
    end
  end

  describe '.domestic_exempt?' do
    it 'returns true for domestic exempt products' do
      expect(described_class.domestic_exempt?(book)).to be(true)
      expect(described_class.domestic_exempt?(food)).to be(true)
    end

    it 'returns false for imported exempt products' do
      expect(described_class.domestic_exempt?(imported_book)).to be(false)
      expect(described_class.domestic_exempt?(imported_food)).to be(false)
    end

    it 'returns false for non-exempt products' do
      expect(described_class.domestic_exempt?(toy)).to be(false)
      expect(described_class.domestic_exempt?(imported_toy)).to be(false)
    end
  end

  describe '.round_up' do
    it 'rounds up to nearest 0.05' do
      expect(described_class.round_up(10.00202)).to eq(10.05)
      expect(described_class.round_up(10.99)).to eq(11.00)
      expect(described_class.round_up(10.292)).to eq(10.30)
      expect(described_class.round_up(10.191)).to eq(10.20)
    end
  end

  describe TaxCalculator::Base do
    it 'raises error when tax_rate is not implemented' do
      calculator = described_class.new(book)
      expect { calculator.send(:tax_rate) }.to raise_error(NotImplementedError)
    end
  end

  describe TaxCalculator::Exempt do
    subject(:calculator) { described_class.new(book) }

    it 'calculates zero tax' do
      expect(calculator.tax_amount).to eq(0.0)
    end

    it 'returns original price' do
      expect(calculator.price_with_taxes).to eq(book.price)
    end
  end

  describe TaxCalculator::Domestic do
    subject(:calculator) { described_class.new(toy) }

    it 'calculates correct tax amount' do
      expected_tax = TaxCalculator.round_up(toy.price * 0.10)
      expect(calculator.tax_amount).to eq(expected_tax)
    end

    it 'calculates correct final price' do
      expected_price = (toy.price + calculator.tax_amount).round(2)
      expect(calculator.price_with_taxes).to eq(expected_price)
    end

    context 'with specific price example' do
      let(:product) { Product.new(name: 'Test', price: 14.99, category: 'toy', imported: false) }
      subject(:calculator) { described_class.new(product) }

      it 'calculates correct values' do
        expect(calculator.tax_amount).to eq(1.50)
        expect(calculator.price_with_taxes).to eq(16.49)
      end
    end
  end

  describe TaxCalculator::Imported do
    context 'with exempt imported product' do
      subject(:calculator) { described_class.new(imported_book) }

      it 'applies only import tax' do
        expected_tax = TaxCalculator.round_up(imported_book.price * 0.05)
        expect(calculator.tax_amount).to eq(expected_tax)
      end

      it 'calculates correct final price' do
        expected_price = (imported_book.price + calculator.tax_amount).round(2)
        expect(calculator.price_with_taxes).to eq(expected_price)
      end
    end

    context 'with non-exempt imported product' do
      subject(:calculator) { described_class.new(imported_perfume) }

      it 'applies both import and basic tax' do
        expected_tax = TaxCalculator.round_up(imported_perfume.price * 0.15)
        expect(calculator.tax_amount).to eq(expected_tax)
      end

      it 'calculates correct final price' do
        expected_price = (imported_perfume.price + calculator.tax_amount).round(2)
        expect(calculator.price_with_taxes).to eq(expected_price)
      end
    end
  end
end
