require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')
require('pry')

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end


post '/transactions' do

  case

  when params.size() == 3
    transaction = Transaction.new(params)
    transaction.save()
    redirect "/"
  when params['tag_name'] != ""
    tag = Tag.new(params)
    tag.save()
    redirect back
  when params['merchant_name'] != ""
    merchant = Merchant.new(params)
    merchant.save()
    redirect back
  end
end


get '/transactions/merchant' do
  @transactions = Transaction.sort_by_merchant
  erb(:"transactions/merchant")
end

get '/transactions/tag' do
  @transactions = Transaction.sort_by_tag
  erb(:"transactions/tag")
end

get '/transactions/date' do
  @transactions = Transaction.sort_by_date
  erb(:"transactions/date")
end

get '/transactions/filter-merchant/:id' do
  binding.pry
  id = params['merchant_id'].to_i
  @transactions = Transaction.filter_merchant(id)
  erb(:"transactions/filter_merchant")
end

post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update
  redirect '/'
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
