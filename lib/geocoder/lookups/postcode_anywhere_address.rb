require 'geocoder/lookups/postcode_anywhere_base'
require 'geocoder/results/postcode_anywhere_address'

module Geocoder::Lookup
  class PostcodeAnywhereAddress < PostcodeAnywhereBase

    BASE_URL_ADDRESS_V1_10 = 'services.postcodeanywhere.co.uk/PostcodeAnywhere/Interactive/Find/v1.10/json.ws'

    def query_url(query)
      format('%s://%s?%s', protocol, BASE_URL_ADDRESS_V1_10, url_query_string(query))
    end

    private

    def query_url_params(query)
      {
        :searchterm => query.sanitized_text,
        :preferredlanguage => 'english',
        :filter => 'none',
        :key => configuration.api_key
      }.merge(super)
    end
  end
end
