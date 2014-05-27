# encoding: utf-8
$: << File.join(File.dirname(__FILE__), '..', '..')
require 'test_helper'

class PostcodeAnywhereAddressFetchTest < GeocoderTestCase

  def setup
    Geocoder.configure(lookup: :postcode_anywhere_address_fetch)
    set_api_key!(:postcode_anywhere_address_fetch)
  end

  def test_result_components_with_fetch
    results = Geocoder.search('50782641', fetch_id: '50782641.00')

    assert_equal 1, results.size
    assert_equal 'Kings Gate, 1 Bravingtons Walk, London, N1 9AE', results.first.street_address
    assert_equal 'Kings Gate, 1 Bravingtons Walk, London, N1 9AE', results.first.address
    assert_equal '50782641', results.first.udprn
    assert_equal [0.0, 0.0], results.first.coordinates
    assert_equal 'High Fliers Publications Ltd', results.first.company
    assert_equal '', results.first.department
    assert_equal 'Kings Gate', results.first.line1
    assert_equal '1 Bravingtons Walk', results.first.line2
    assert_equal '', results.first.line3
    assert_equal '', results.first.line4
    assert_equal '', results.first.line5
    assert_equal 'London', results.first.posttown
    assert_equal '', results.first.county
    assert_equal 'N1 9AE', results.first.postcode
    assert_equal 'N1 9AE', results.first.postal_code
    assert_equal '62113', results.first.mailsort
    assert_equal '(N19AE1BF)', results.first.barcode
    assert_equal 'SmallBusiness', results.first.type
    assert_equal '1B', results.first.deliverypointsuffix
    assert_equal '', results.first.subbuilding
    assert_equal 'Kings Gate', results.first.buildingname
    assert_equal '1', results.first.buildingnumber
    assert_equal 'Bravingtons Walk', results.first.primarystreet
    assert_equal '', results.first.secondarystreet
    assert_equal '', results.first.doubledependentlocality
    assert_equal '', results.first.dependentlocality
    assert_equal '', results.first.pobox
    assert_equal 'Bravingtons', results.first.primarystreetname
    assert_equal 'Walk', results.first.primarystreettype
    assert_equal '', results.first.secondarystreetname
    assert_equal '', results.first.secondarystreettype
    assert_equal 'England', results.first.countryname
    assert_equal 'GB', results.first.countryiso2
    assert_equal 'GBR', results.first.countryiso3
    assert results.first.is_a?(Geocoder::Result::PostcodeAnywhereAddressFetch)
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
