require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')


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

post '/transactions/:id/delete' do
Transaction.delete(params[:id])
redirect back
end

get '/transactions/:id/edit' do
  id = params[:id].to_i
  @transactions = Transaction.find(id)
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/edit")

end

post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update
  redirect '/'
end

get '/transactions/merchant' do
  @transactions = Transaction.sort_by_merchant
  erb(:"transactions/merchant")
end

get '/transactions/tag' do
  @transactions = Transaction.sort_by_tag
  erb(:"transactions/tag")
end
