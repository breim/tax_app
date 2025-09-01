# frozen_string_literal: true

require './src/text_parser'

RSpec.describe TextParser do
  let(:book) { '2 book at 12.49' }
  let(:medicine) { '1 packet of headache pills at 9.75' }
  let(:imported_chocolate) { '1 imported box of chocolates at 10.00' }
  let(:perfume) { '1 bottle of perfume at 18.99' }

  describe '.parse' do
    it 'parse quantity from input' do
      expect(described_class.parse(book)[:quantity]).to eq(2)
      expect(described_class.parse(medicine)[:quantity]).to eq(1)
    end

    it 'parse product name' do
      result = described_class.parse(book)
      expect(result[:product].name).to eq('book')
    end

    it 'parse product category' do
      expect(described_class.parse(book)[:product].category).to eq('book')
      expect(described_class.parse(imported_chocolate)[:product].category).to eq('food')
      expect(described_class.parse(medicine)[:product].category).to eq('medicine')
      expect(described_class.parse(perfume)[:product].category).to eq('others')
    end

    it 'parse product price' do
      expect(described_class.parse(book)[:product].price).to eq(12.49)
      expect(described_class.parse(medicine)[:product].price).to eq(9.75)
    end

    it 'parse  imported products correctly' do
      expect(described_class.parse(imported_chocolate)[:product].imported).to be true
      expect(described_class.parse(book)[:product].imported).to be false
    end
  end
end
