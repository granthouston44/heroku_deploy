require_relative('../models/merchant')
require('pry')

  Merchant.delete_all()

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
binding.pry

nil
