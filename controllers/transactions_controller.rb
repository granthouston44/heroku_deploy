require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')
require('pry')
require_relative('../app.rb')

#new
get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

#create
post '/transactions' do
  case
  when params['tag_name'] != ""
    tag = Tag.new(params)
    tag.save()
    params['tag_id'] = tag.id
    redirect back
  when params['merchant_name'] != ""
    merchant = Merchant.new(params)
    merchant.save()
    params['merchant_name'] = merchant.id
    redirect back
  when params
    transaction = Transaction.new(params)
    transaction.save()
    redirect "/"
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

post '/transactions/filter-merchant'do

 id = params['merchant_id'].to_i
 @transactions = Transaction.filter_merchant(id)
 @tags = Tag.all
 @merchants = Merchant.all
 erb(:home)
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
