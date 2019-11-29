require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require('pry')

  Transaction.delete_all()
  Merchant.delete_all()
  Tag.delete_all()


  merchant1 = Merchant.new({
    'name' => 'Amazon'
    })
  merchant1.save()
  merchant2 = Merchant.new({
    'name' => 'Costco'
    })
  merchant2.save()
  merchant3 = Merchant.new({
    'name' => 'Game'
    })
  merchant3.save()


tag1 = Tag.new({
  'name' => 'groceries'
})
tag1.save()
tag2 = Tag.new({
  'name' => 'misc'
  })
tag2.save()
tag3 = Tag.new({
  'name' => 'entertainment'
  })
tag3.save()

transaction1 = Transaction.new({
  'amount' => 3.50,
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id
  })
transaction1.save()

  transaction2 = Transaction.new({
    'amount' => 32.99,
    'merchant_id' => merchant2.id,
    'tag_id' => tag1.id
    })
  transaction2.save()

binding.pry
nil
