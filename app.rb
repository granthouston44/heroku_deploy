require('sinatra')
require('sinatra/contrib/all')
also_reload('./models/*')

require_relative("./controllers/transactions_controller")

get '/' do
  @transactions = Transaction.all
  erb(:"home")
end
