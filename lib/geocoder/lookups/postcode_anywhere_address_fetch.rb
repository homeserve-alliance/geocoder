require 'geocoder/lookups/postcode_anywhere_base'
require 'geocoder/results/postcode_anywhere_address_fetch'

module Geocoder::Lookup
  class PostcodeAnywhereAddressFetch < PostcodeAnywhereBase

    BASE_URL_ADDRESS_FETCH_V1_30 = 'services.postcodeanywhere.co.uk/PostcodeAnywhere/Interactive/RetrieveById/v1.30/json.ws'

    def query_url(query)
      format('%s://%s?%s', protocol, BASE_URL_ADDRESS_FETCH_V1_30, url_query_string(query))
    end

    private

    def query_url_params(query)
      # We require the fetch_id param here. Raise or not to raise?
      fetch_id = query.options[:fetch_id] || ''

      {
        :id => fetch_id,
        :searchterm => query.sanitized_text, # not calling this breaks lots of so called 'tests'
        :preferredlanguage => 'english',
        :filter => 'none',
        :key => configuration.api_key
      }.merge(super)
    end
  end
end
