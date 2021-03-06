# encoding: utf-8
$: << File.join(File.dirname(__FILE__), '..', '..')
require 'test_helper'

class PostcodeAnywhereAddressTest < GeocoderTestCase

  def setup
    Geocoder.configure(lookup: :postcode_anywhere_address)
    set_api_key!(:postcode_anywhere_address)
  end

  def test_result_components_with_placename_search
    results = Geocoder.search('N1 9AE')

    assert_equal 2, results.size
    assert_equal 'High Fliers Publications Ltd', results.first.street_address
    assert_equal 'High Fliers Publications Ltd', results.first.address
    assert_equal 'Kings Gate 1 Bravingtons Walk London N1', results.first.place
    assert_equal '50782641.00', results.first.id
    assert_equal [Float::INFINITY, Float::INFINITY], results.first.coordinates
    assert_equal '', results.first.city
    assert results.first.is_a?(Geocoder::Result::PostcodeAnywhereAddress)

    assert_equal 'High Fliers Research Ltd', results.last.street_address
    assert_equal 'High Fliers Research Ltd', results.last.address
    assert_equal 'Kings Gate 1 Bravingtons Walk London N1', results.last.place
    assert_equal '50782643.00', results.last.id
    assert_equal [Float::INFINITY, Float::INFINITY], results.first.coordinates
    assert_equal '', results.last.city
    assert results.last.is_a?(Geocoder::Result::PostcodeAnywhereAddress)
  end

  def test_result_fetch
    result = Geocoder.search('N1 9AE').first

    fetch_results = result.fetch
    assert fetch_results.first.is_a?(Geocoder::Result::PostcodeAnywhereAddressFetch)
  end

  def test_no_results
    assert_equal [], Geocoder.search('no results')
  end

  def test_key_limit_exceeded_error
    Geocoder.configure(always_raise: [Geocoder::OverQueryLimitError])

    assert_raises Geocoder::OverQueryLimitError do
      Geocoder.search('key limit exceeded')
    end
  end

  def test_unknown_key_error
    Geocoder.configure(always_raise: [Geocoder::InvalidApiKey])

    assert_raises Geocoder::InvalidApiKey do
      Geocoder.search('unknown key')
    end
  end

  def test_generic_error
    Geocoder.configure(always_raise: [Geocoder::Error])

    exception = assert_raises(Geocoder::Error) do
      Geocoder.search('generic error')
    end
    assert_equal 'A generic error occured.', exception.message
  end
end
