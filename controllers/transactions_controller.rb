require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')



get '/transactions/new' do
  erb(:"transactions/new")
end

get '/transactions/merchant' do
  erb(:"transactions/merchant")
end

get '/transactions/tag' do
  erb(:"transactions/tag")
end
