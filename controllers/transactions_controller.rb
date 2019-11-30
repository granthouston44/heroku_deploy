require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')


get '/transactions/' do
  @transactions = Transaction.all
erb(:"transactions/index")
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save()
  redirect "/"
end

get '/transactions/merchant' do
  @transactions = Transaction.sort_by_merchant
  erb(:"transactions/merchant")
end

get '/transactions/tag' do
  @transactions = Transaction.sort_by_tag
  erb(:"transactions/tag")
end
