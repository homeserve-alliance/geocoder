# encoding: utf-8
$: << File.join(File.dirname(__FILE__), '..', '..')
require 'test_helper'

class PostcodeAnywhereUkTest < GeocoderTestCase

  def setup
    Geocoder.configure(lookup: :postcode_anywhere_uk)
    set_api_key!(:postcode_anywhere_uk)
  end

  def test_result_components
    results = Geocoder.search('Madison Square Garden')

    assert_equal 1, results.size
    assert_equal 'Maidstone, Kent, TQ 76153 55386', results.first.address
    assert_equal [51.2703, 0.5238], results.first.coordinates
    assert_equal 'Maidstone', results.first.city
  end

  def test_WR26NJ
    results = Geocoder.search('WR26NJ')

    assert_equal 1, results.size
    assert_equal 'Moseley Road, Hallow, Worcester, SO 81676 59425', results.first.address
    assert_equal [52.2327, -2.2697], results.first.coordinates
    assert_equal 'Hallow', results.first.city
  end

  def test_no_results
    assert_equal [], Geocoder.search('no results')
  end
end