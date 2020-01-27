require('sinatra')
require('sinatra/contrib/all') if development?


require_relative("./controllers/transactions_controller")

get '/' do

  @transactions = Transaction.sort_by_date
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"home")
end
