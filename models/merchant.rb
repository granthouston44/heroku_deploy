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

def self.delete_all()
  sql = "DELETE FROM merchants;"
  SqlRunner.run(sql)
end

def save()
sql = "
INSERT INTO merchants
(
  name
)
VALUES
(
  $1
)
RETURNING id
"
values = [@name]
results = SqlRunner.run(sql, values)
#the returing sql command is bringing back the id
#the returned id is then assigned to the instance
#because SQL always returns an array, we want to access
#the first element of the array, then the key 'id' as
#as that is what parameters that the Merchant object takes
@id = results.first()['id'].to_i
end






end
