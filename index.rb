# Task 
# implement a Tax Calculator in Ruby that determines the correct tax rate for different transactions based on the buyer's location and product/service type.

# Plan for Implementation
# Define a TaxCalculator class - will take the buyer location, product/service type, and buyer type (individual/company) as inputs
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
  # defining the attributes the class object should accpet as inputs
  attr_accessor :buyer_location, :product_type, :buyer_type, :service_location

  # initialize the taxcalculator class
  def initialize(buyer_location, product_type, buyer_type, service_location = nil)
    @buyer_location = buyer_location
    @product_type = product_type
    @buyer_type = buyer_type
    @service_location = service_location
  end
end
