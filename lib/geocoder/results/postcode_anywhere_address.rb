require 'geocoder/results/base'

module Geocoder::Result
  class PostcodeAnywhereAddress < Base

    # This API does not return any co-ords for a result, we need to return a
    # pair of floats here though.
    # It is prefereable to implement this API via the Geocode gem despite not
    # technically geocoding a request.
    def coordinates
      warn '[Warning]: PostcodeAnywhereAddress lookup does not support coordinates. '\
        'Please use PostcodeAnywhereUk lookup to Geocode a location.'
      [Float::INFINITY, Float::INFINITY]
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

    # This is a UK only API; all results are UK specific and
    # so ommitted from API response.
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
      Geocoder::Query.new(id, lookup: :postcode_anywhere_address_fetch).execute
    end
  end
end
