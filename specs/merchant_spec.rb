require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/merchant')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class MerchantTest < MiniTest::Test

def test_create_merchant_object
  Merchant.new({
    "name" => "Amazon"
    })
end


end
