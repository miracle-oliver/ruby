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

  # setting up the task calculator method
  def calculate_tax
    # testing for cases relating to product_type
    case product_type
    when 'good'
      # the case the product type is goods, we check for the buyers location and buyer type either individual or company
      goods(buyer_location, buyer_type)
    when 'service'
      # the case the product_type is service, we check if it's an onsite service or digital service
      if service_location 
        onsite_service(service_location)
      else
        digital_service(buyer_location, buyer_type)
      end
    else
      "Invalid product type"
    end
  end

  # setting goods, digital_service & onsite_service method to private, because they are only used by the calculate tax method and explicitly needed outside.
  private

  # in the case the selected product type is goods, check for the buyers location, if it's spain return spainish VAT, else check if the buyer is from an EU country, if yes and the buyer is an individual return the local vat for that location else consider the person as a company and return reverse charge, if the buyer is not from the the EU country, return Export (No VAT) 
  def goods(buyer_location, buyer_type)
    if buyer_location == "Spain"
      SPANISH_VAT
    elsif EU_COUNTRIES.include?(buyer_location)
      buyer_type == "individual" ? "Local VAT (#{buyer_location})" : "Reverse Charge"
    else
      "Export (No VAT)"
    end
  end

  # the case the product_type is a service and digital service, check if the buyers location is spain, if true return spainish VAT, if alse check if the buy is from an EU country if true, check if the buyer is an individual, if true return locat VAT for that location else return reverse charge for a company. if the buyer is not from an EU country return No VAT
  def digital_service(buyer_location, buyer_type)
    if buyer_location == "Spain"
      SPANISH_VAT
    elsif EU_COUNTRIES.include?(buyer_location)
      buyer_type == "individual" ? "Local VAT (#{buyer_location})" : "Reverse Charge"
    else
      "No VAT"
    end
  end

  # the case the service type and service is onsite service, check the persons location, if it's spain return spanish VAT else return local VAT of that location
  def onsite_service(service_location)
    service_location == "Spain" ? SPANISH_VAT : "Local VAT (#{service_location})"
  end
end


# test

# a buyer from Spain, buying a good and an individual
tax1 = TaxCalculator.new("Spain", "good", "individual").calculate_tax

# a buyer from Germany, looking for a service, the buyer is a comapny looking for an onsite service
tax2 = TaxCalculator.new("Germany", "service", "company", "London").calculate_tax

# a buyer from USA looking for a service, he's an individual looking for a digital service
tax3 = TaxCalculator.new("USA", "service", "individual").calculate_tax

# a buyer fr0m Canada buying a good, he's an individual
tax4 = TaxCalculator.new("Canada", "good", "individual").calculate_tax

puts tax1 # Output: 21
puts tax2 # Output: "Local VAT (London)"
puts tax3 # Output: "No VAT"
puts tax4 # Output: "Export (No VAT)"
