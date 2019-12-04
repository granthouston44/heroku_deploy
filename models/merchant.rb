require_relative('../db/sql_runner')

class Merchant

  attr_accessor :merchant_name

  #don't change as it is linked to the db
  attr_reader :id

  def initialize(merchant_details)
    #as the object contains a hash, we want to acces the
    #right key for the relevant property
    #if there is an id, get the value and make sure it is an int
    @id = merchant_details['id'].to_i if merchant_details['id']
    @merchant_name = merchant_details['merchant_name']
  end

  def self.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO merchants
    (
      merchant_name
    )
    VALUES
    (
      $1
    )
    RETURNING id
    "
    values = [@merchant_name]
    results = SqlRunner.run(sql, values)
    #the RETURNING sql command is bringing back the id
    #because SQL always returns an array of hashes, it will return
    # the id inside an array, contained within a hash
    # we want to access both the array and the hash to store the
    # id into @id instance variable
    # #the first element of the array, then the key 'id' as
    #as that is what parameters that the Merchant object takes
    @id = results.first()['id'].to_i
  end

  def self.all
    sql = "
    SELECT * FROM merchants;
    "
    result = SqlRunner.run(sql)
    #SQL runner will not return merchant objects, therefore we want to map
    #the results as new merchant objects within an array
    #the merchant object takes in a hash as evidence in our initialize and seeds file
    #when creating new Merchants.
    #(result from SqlRunner) will return an array of hashes
    #in the map, we are telling it for each entry in the array, create a new
    #merchant object using the hashes contained within the array
    return result.map {|merchant| Merchant.new(merchant)}
  end

  def update
    sql =
    "
    UPDATE merchants
    SET merchant_name =
    $1
    WHERE id = $2
    "
    values = [@merchant_name, @id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql =
    "
    SELECT * FROM merchants
    WHERE id = $1
    "
    values = [id]
    merchants = SqlRunner.run(sql,values).first
    return Merchant.new(merchants)
  end

  def self.delete(id)
    sql =
    "
    DELETE FROM merchants
    WHERE id = $1
    "
    values = [id]
    SqlRunner.run(sql, values)
  end





end
