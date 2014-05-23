require 'geocoder/results/base'

module Geocoder::Result
  class PostcodeAnywhereAddress < Base

    def coordinates
      []
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

    def place
      @data['Place']
    end

    def country
      'United Kingdom'
    end

    def country_code
      'UK'
    end

    def id
      @data['Id']
    end
  end
end
