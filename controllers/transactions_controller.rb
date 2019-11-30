require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')



get '/transactions/new' do
  erb(:"transactions/new")
end
