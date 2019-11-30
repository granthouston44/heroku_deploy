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
  merchant4 = Merchant.new({
    'name' => 'Amazon'
    })
  merchant4.save()
  merchant5 = Merchant.new({
    'name' => 'Costco'
    })
  merchant5.save()
  merchant6 = Merchant.new({
    'name' => 'Game'
    })
  merchant6.save()



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
tag4 = Tag.new({
  'name' => 'groceries'
})
tag4.save()
tag5 = Tag.new({
  'name' => 'misc'
  })
tag5.save()
tag6 = Tag.new({
  'name' => 'entertainment'
  })
tag6.save()

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
transaction3 = Transaction.new({
  'amount' => 3.50,
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id
  })
transaction3.save()

  transaction4 = Transaction.new({
    'amount' => 32.99,
    'merchant_id' => merchant2.id,
    'tag_id' => tag1.id
    })
  transaction4.save()
transaction5 = Transaction.new({
  'amount' => 3.50,
  'merchant_id' => merchant1.id,
  'tag_id' => tag2.id
  })
transaction5.save()

  transaction6 = Transaction.new({
    'amount' => 32.99,
    'merchant_id' => merchant2.id,
    'tag_id' => tag2.id
    })
  transaction6.save()


#potential use for sorting by order
# transactions = Transaction.all
# for transaction in transactions
# p transaction.merchant.name
# p transaction.tag.name
# end


# #playing about with this
# p transactions.map do |transaction|
# transaction.merchant.name
# transaction.tag.name
# transaction.amount
# transaction.date

binding.pry
nil
