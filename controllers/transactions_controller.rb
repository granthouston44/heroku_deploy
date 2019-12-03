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
    tag = params.select {|k,v| k == "tag_name"}
    tag = Tag.new(tag)
    tag.save()
    redirect back
  when params['merchant_name'] != ""
    merchant = params.select {|k,v| k == "merchant_name"}
    merchant = Merchant.new(merchant)
    merchant.save()
    redirect back
  when params
    transaction_hash = params.reject{ |k,v| k == 'date_of_transaction' }
    transaction = Transaction.new(transaction_hash)
    transaction.save()
    if params[:date_of_transaction] != ""
      format_date = params[:date_of_transaction]
      date = Date.strptime(format_date, '%Y-%m-%d')
      transaction.date = date.strftime('%d-%m-%Y')
      transaction.update
    end
    redirect "/"
  end
end



get '/transactions/edit-merchant' do
  @merchants = Merchant.all()
  erb(:"transactions/edit_merchant")
end

get '/transactions/edit-tag' do
  @tags = Tag.all
  erb(:"transactions/edit_tag")
end

get '/transactions/merchant' do
  @transactions = Transaction.sort_by_merchant
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"home")
end

get '/transactions/tag' do
  url = request.url
  @transactions = Transaction.sort_by_tag
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"home")
end

get '/transactions/date' do
  @transactions = Transaction.sort_by_date
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"home")
end

post '/transactions/filter-merchant'do

id = params['merchant_id'].to_i
@transactions = Transaction.filter_merchant(id)
@tags = Tag.all
@merchants = Merchant.all
erb(:home)
end

post '/transactions/filter-tag' do
  id = params['tag_id'].to_i
  @transactions = Transaction.filter_tag(id)
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"home")
end

post '/transactions/filter-date' do
  id = params['date_of_transaction']
  @transactions = Transaction.filter_date(id)
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"home")
end

post '/transactions/edit-merchant' do
  id = params[:merchant_id].to_i
  merchant = Merchant.find(id)
  merchant.merchant_name = params['merchant_name']
  merchant.update
  redirect back
end

post '/transactions/edit-tag' do
  id = params[:tag_id].to_i
  tag = Tag.find(id)
  tag.tag_name = params['tag_name']
  tag.update
  redirect back
end

post '/transactions/add-merchant' do
  merchant = params.select {|k,v| k == "merchant_name"}
  merchant = Merchant.new(merchant)
  merchant.save()
  redirect back
end

post '/transactions/add-tag' do
  tag = params.select {|k,v| k == "tag_name"}
  tag = Tag.new(tag)
  tag.save()
  redirect back
end

post '/transactions/:id' do
  transaction_hash = params.reject{ |k,v| k == 'date_of_transaction' }
  transaction = Transaction.new(transaction_hash)
  transaction.update
  if params[:date_of_transaction] != ""
    format_date = params[:date_of_transaction]
    date = Date.strptime(format_date, '%Y-%m-%d')
    transaction.date = date.strftime('%d-%m-%Y')
    transaction.update
  end
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
