require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/transaction')
require_relative('../models/tag')
require_relative('../models/merchant')


MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class TransactionTest < MiniTest::Test

def test_can_create_transaction_object

  merchant1 = Merchant.new({
    'name' => 'Amazon'
    })

  tag1 = Tag.new({
    'name' => 'groceries'
  })

  Transaction.new({
    'amount' => 3.50,
    'merchant_id' => merchant1.id,
    'tag_id' => tag1.id
    })
end


end
