require_relative('../models/merchant')
require('pry')

  Merchant.delete_all()

  merchant1 = Merchant.new({
    'name' => 'Amazon'
    })

  merchant2 = Merchant.new({
    'name' => 'Costco'
    })

  merchant1 = Merchant.new({
    'name' => 'Game'
    })

binding.pry

nil
