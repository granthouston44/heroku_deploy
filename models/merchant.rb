require_relative('../db/sql_runner')

class Merchant

attr_accessor :name

#don't change as it is linked to the db
attr_reader :id

def initialize(merchant_details)
  #as the object contains a hash, we want to acces the
  #right key for the relevant property
  #if there is an id, get the value and make sure it is an int
  @id = merchant_details['id'].to_i if merchant_details['id']
  @name = merchant_details['name']
end





end
