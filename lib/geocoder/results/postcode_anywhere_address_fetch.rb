require 'geocoder/results/base'

module Geocoder::Result
  class PostcodeAnywhereAddressFetch < Base

    # This API does not return any co-ords for a result, we need to return a
    # pair of floats here though.
    # It is prefereable to implement this API via the Geocode gem despite not
    # technically geocoding a request.
    def coordinates
      warn '[Warning]: PostcodeAnywhereAddressFetch lookup does not support coordinates. '\
        'Please use PostcodeAnywhereUk lookup to Geocode a location.'
      [0.0, 0.0]
    end

    def blank_result
      ''
    end
    alias_method :state, :blank_result
    alias_method :state_code, :blank_result

    def address
      [@data['Line1'], @data['Line2'], @data['PostTown'], @data['Postcode']].join(', ')
    end
    alias_method :street_address, :address

    def city
      @data['PostTown']
    end

    def country
      @data['CountryName']
    end

    def country_code
      @data['CountryISO2']
    end

    # PostcodeAnywhereAddress specific reponse attrs; List all keys and
    # then create methods for each.
    def self.response_attributes
      %w(Udprn Company Department Line1 Line2 Line3 Line4 Line5 PostTown County
          Postcode Mailsort Barcode Type DeliveryPointSuffix SubBuilding BuildingName
          BuildingNumber PrimaryStreet SecondaryStreet DoubleDependentLocality
          DependentLocality PoBox PrimaryStreetName PrimaryStreetType SecondaryStreetName
          SecondaryStreetType CountryName CountryISO2 CountryISO3
        )
    end

    response_attributes.each do |a|
      unless method_defined?(a.downcase)
        define_method a.downcase do
          @data[a]
        end
      end
    end
    alias_method :postal_code, :postcode
  end
end
