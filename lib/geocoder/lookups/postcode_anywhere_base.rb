require 'geocoder/lookups/base'

module Geocoder::Lookup
  class PostcodeAnywhereBase < Base

    def required_api_key_parts
      %w(key)
    end

    def name
      self.class.name
    end

    protected

    def results(query)
      response = fetch_data(query)
      return [] if response.nil? || !response.is_a?(Array) || response.empty?

      raise_exception_for_response(response[0]) if response[0]['Error']
      response
    end

    def raise_exception_for_response(response)
      case response['Error']
      when '8', '17' # api docs say these two codes are the same error
        raise_error(Geocoder::OverQueryLimitError, response['Cause']) || warn(response['Cause'])
      when '2'
        raise_error(Geocoder::InvalidApiKey, response['Cause']) || warn(response['Cause'])
      else # anything else just raise general error with the api cause
        raise_error(Geocoder::Error, response['Cause']) || warn(response['Cause'])
      end
    end
  end
end
