require 'geocoder/lookups/postcode_anywhere_base'
require 'geocoder/results/postcode_anywhere_uk'

module Geocoder::Lookup
  class PostcodeAnywhereUk < PostcodeAnywhereBase

    BASE_URL_GEOCODE_V2_00 = 'services.postcodeanywhere.co.uk/Geocoding/UK/Geocode/v2.00/json.ws'

    def name
      'PostcodeAnywhereUk'
    end

    def query_url(query)
      format('%s://%s?%s', protocol, BASE_URL_GEOCODE_V2_00, url_query_string(query))
    end

    private

    def query_url_params(query)
      {
        :location => query.sanitized_text,
        :key => configuration.api_key
      }.merge(super)
    end
  end
end
