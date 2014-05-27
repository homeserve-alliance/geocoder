require 'geocoder/results/base'

module Geocoder::Result
  class PostcodeAnywhereAddressFetch < Base

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
    alias_method :postal_code, :blank_result
    alias_method :city, :blank_result

    def address
      @data['StreetAddress']
    end
    alias_method :street_address, :address

    def country
      'United Kingdom'
    end

    def country_code
      'UK'
    end

    # PostcodeAnywhereAddress specific reponse attrs

    def place
      @data['Place']
    end

    def id
      @data['Id']
    end

    # Request the specific address information for this Result.
    # This will make another request to PostcodeAnywhere with the id.
    def fetch
      Geocoder::Query.new(address, fetch_id: id, lookup: :postcode_anywhere_address_fetch).execute
    end
  end
end
