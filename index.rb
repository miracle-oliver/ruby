# Task 
# implement a Tax Calculator in Ruby that determines the correct tax rate for different transactions based on the buyer's location and product/service type.

# Plan for Implementation
# Define a TaxCalculator class - will take the buyer's location, product/service type, and buyer's type (individual/company) as inputs
# methods - Goods (good), Digital Services (service, digital), Onsite Services (service, onsite)


# Standard spanish VAT - declining
SPANISH_VAT = 21

# List of all EU countries
EU_COUNTRIES = [
  "Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czech Republic", "Denmark",
  "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy",
  "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal",
  "Romania", "Slovakia", "Slovenia", "Spain", "Sweden"
]

# creating a tasx calculator class
class TaxCalculator
  # defining the attributes the class object should accept as inputs
  attr_accessor :buyer_location, :product_type, :buyer_type, :service_location

  # initialize the taxcalculator class
  def initialize(buyer_location, product_type, buyer_type, service_location = nil)
    @buyer_location = buyer_location
    @product_type = product_type
    @buyer_type = buyer_type
    @service_location = service_location
  end

  # setting up the task calculator method
  def calculate_tax
    # check for buyer's location
    if buyer_location.downcase == 'spain'
      SPANISH_VAT
    else
      # testing for cases relating to product_type
      case product_type
      when 'good'
        # the case the product type is goods, we check for the buyers location and buyer type either individual or company
        check_isEU(buyer_location, buyer_type, "Export (No VAT)")
      when 'service'
        # the case the product_type is service, we check if it's an onsite service or digital service
        if service_location 
          "Local VAT (#{service_location})"
        else
          check_isEU(buyer_location, buyer_type, "No VAT")
        end
      else
        "Invalid product type"
      end
    end
  end

  # setting goods, digital_service & onsite_service method to private, because they are only used by the calculate tax method and not explicitly needed outside.
  private

  # check if user's location is one if the EU countries, if true check if the user is an individual or a company
  def check_isEU(buyer_location, buyer_type, default_response)
    if EU_COUNTRIES.include?(buyer_location.capitalize)
      buyer_type.downcase == "individual" ? "Local VAT (#{buyer_location.capitalize})" : "Reverse Charge"
    else 
      default_response
    end
  end
    
end


# test

# a buyer from Spain, buying a good and an individual
tax1 = TaxCalculator.new("Spain", "good", "individual").calculate_tax

# a buyer from Germany, looking for a service, the buyer is a comapny looking for an onsite service
tax2 = TaxCalculator.new("Germany", "service", "company", "london").calculate_tax

# a buyer from USA looking for a service, he's an individual looking for a digital service
tax3 = TaxCalculator.new("USA", "service", "individual").calculate_tax

# a buyer fr0m Canada buying a good, he's an individual
tax4 = TaxCalculator.new("Canada", "good", "individual").calculate_tax

puts tax1 # Output: 21
puts tax2 # Output: "Local VAT (London)"
puts tax3 # Output: "No VAT"
puts tax4 # Output: "Export (No VAT)"
