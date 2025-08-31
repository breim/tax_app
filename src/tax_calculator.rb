# frozen_string_literal: true

require 'bigdecimal'

module TaxCalculator
  IMPORTED_TAX_RATE = 0.05
  BASE_TAX_RATE = 0.10
  EXEMPT_CATEGORIES = %w[book food medicine].freeze

  def self.for(product)
    return Exempt.new(product) if domestic_exempt?(product)
    return Imported.new(product) if product.imported

    Domestic.new(product)
  end

  def self.exempt_category?(product)
    EXEMPT_CATEGORIES.include?(product.category)
  end

  def self.domestic_exempt?(product)
    exempt_category?(product) && !product.imported
  end

  def self.round_up(amount)
    bd_amount = BigDecimal(amount.to_s)
    bd_nickel = BigDecimal('0.05')

    result = (bd_amount / bd_nickel).ceil * bd_nickel
    result.to_f.round(2)
  end

  class Base
    attr_reader :product

    def initialize(product)
      @product = product
    end

    def price_with_taxes
      (@product.price + tax_value).round(2)
    end

    def tax_value
      return 0.0 unless tax_rate.positive?

      tax_amount = @product.price * tax_rate
      TaxCalculator.round_up(tax_amount)
    end

    private

    def exempt_category?(product)
      TaxCalculator.exempt_category?(product)
    end

    def tax_rate
      raise NotImplementedError, 'Subclasses must implement tax_rate'
    end
  end

  class Exempt < Base
    private

    def tax_rate
      0
    end
  end

  class Domestic < Base
    private

    def tax_rate
      TaxCalculator::BASE_TAX_RATE
    end
  end

  class Imported < Base
    private

    def tax_rate
      rate = TaxCalculator::IMPORTED_TAX_RATE
      rate += TaxCalculator::BASE_TAX_RATE unless exempt_category?(@product)
      rate
    end
  end
end
