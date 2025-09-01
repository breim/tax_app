# ProductTaxApp

> **Note:** This documentation and only the `round_up` function were generated using ChatGPT for code generation.

## About the Project

ProductTaxApp is a Ruby application for calculating taxes on products in a shopping cart system. The application simulates a checkout that calculates taxes based on product categories and origin (imported or domestic).

### Features

- **Tax Calculation**: Applies different tax rates based on product category
- **Imported Products**: Additional 5% tax for imported products
- **Exempt Categories**: Books, food, and medicine are exempt from basic tax
- **Rounding**: Taxes are rounded up to the nearest 5-cent increment
- **Interactive Interface**: CLI for adding products and viewing receipts

### Tax Rules

- **Basic Rate**: 10% for non-exempt products
- **Import Rate**: Additional 5% for imported products
- **Exempt Categories**: book, food, medicine (only from basic tax)
- **Rounding**: Taxes rounded up to the nearest 0.05 multiple

## Requirements

- **Ruby**: 3.2.2
- **Bundler**: For dependency management

## Installation

1. Clone the repository:
```bash
git clone git@github.com:breim/tax_app.git
cd tax_app
```

2. Install dependencies:
```bash
bundle install
```

## How to Use

### Run the Application

```bash
ruby product_tax_app.rb
```

### Input Format

Enter products in the format: `quantity item at price`

**Examples:**
```
2 book at 12.49
1 imported bottle of perfume at 47.50
1 chocolate bar at 0.85
1 imported box of chocolates at 11.25
```

### Available Commands

- `total` - Shows the final receipt with taxes
- `clear` - Clears the cart
- `exit` or `quit` - Exits the application

### Usage Example

```
=== ProductTaxApp ===
Enter items in the format: 'quantity item at price'
Example: '2 book at 12.49' or '1 imported bottle of perfume at 47.50'
Type 'total' to see the final receipt
Type 'clear' to empty the cart
Type 'exit' to quit
====================
> 1 book at 12.49
Added: 1 book - $12.49
> 1 imported bottle of perfume at 47.50
Added: 1 imported bottle of perfume - $47.50
> total

==============================
RECEIPT
==============================
1 book: 12.49
1 imported bottle of perfume: 54.65
------------------------------
Sales Taxes: 7.65
Total: 67.14
==============================
```

## Test Cases

The application handles the following test scenarios correctly:

### Input Basket 1
```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```
**Expected Output:**
```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

### Input Basket 2
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```
**Expected Output:**
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

### Input Basket 3
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```
**Expected Output:**
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

## Running Tests

```bash
# Run all tests
bundle exec rspec

# Run tests with documentation format
bundle exec rspec --format documentation

# Run a specific test file
bundle exec rspec spec/src/checkout_spec.rb
```

## Running Linter

```bash
# Check code style
bundle exec rubocop

# Auto-fix style issues
bundle exec rubocop -a
```

## Project Structure

```
├── src/
│   ├── product.rb          # Product model
│   ├── cart.rb            # Shopping cart
│   ├── checkout.rb        # Checkout system
│   ├── tax_calculator.rb  # Tax calculator
│   └── text_parser.rb     # Text input parser
├── spec/
│   └── src/               # Unit tests
├── product_tax_app.rb     # Main application
├── Gemfile               # Dependencies
└── README.md            # This file
```

## Dependencies

- `rspec` - Testing framework
- `rubocop` - Code linter and formatter
- `simplecov` - Test coverage
- `byebug` - Debugger

## Test Coverage

Test coverage is automatically generated and can be viewed at `coverage/index.html` after running tests.
## Development Notes

> **Note:** Given more time, I would have liked to refactor the test suite to use Factory Bot instead of manually creating objects in each test. This would make the tests more maintainable and reduce code duplication across test files.

## Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request