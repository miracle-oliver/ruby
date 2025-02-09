require_relative './index'  
require 'rspec'

RSpec.describe TaxCalculator do
  describe "#calculate_tax" do
    context "when the buyer is from Spain buying a good" do
      it "returns 21 (Spanish VAT)" do
        tax = TaxCalculator.new("Spain", "good", "individual").calculate_tax
        expect(tax).to eq(21)
      end
    end

    context "when a German company is looking for an onsite service in London" do
      it "returns 'Local VAT (London)'" do
        tax = TaxCalculator.new("Germany", "service", "company", "London").calculate_tax
        expect(tax).to eq("Local VAT (London)")
      end
    end

    context "when a USA individual is looking for a digital service" do
      it "returns 'No VAT'" do
        tax = TaxCalculator.new("USA", "service", "individual").calculate_tax
        expect(tax).to eq("No VAT")
      end
    end

    context "when a Canadian individual is buying a good" do
      it "returns 'Export (No VAT)'" do
        tax = TaxCalculator.new("Canada", "good", "individual").calculate_tax
        expect(tax).to eq("Export (No VAT)")
      end
    end

    context "when a French individual buys a digital service" do
      it "returns 'Local VAT (France)'" do
        tax = TaxCalculator.new("France", "service", "individual").calculate_tax
        expect(tax).to eq("Local VAT (France)")
      end
    end

    context "when a French company buys a digital service" do
      it "returns 'Reverse Charge'" do
        tax = TaxCalculator.new("France", "service", "company").calculate_tax
        expect(tax).to eq("Reverse Charge")
      end
    end

    context "when the product type is invalid" do
      it "returns 'Invalid product type'" do
        tax = TaxCalculator.new("USA", "invalid_type", "individual").calculate_tax
        expect(tax).to eq("Invalid product type")
      end
    end
  end
end
