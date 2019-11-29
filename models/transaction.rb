require_relative('../db/sql_runner')

class Transaction

def initialize(transaction_details)
  @id = transaction_details['id'].to_i if transaction_details['id']
  @amount = transaction_details['amount']
  @date = transaction_details['timestamp']
  @merchant_id = transaction_details['merchant_id']
  @tag_id = transaction_details['tag_id']
end

def save()
  sql =
  "
  INSERT INTO transactions
  (
    merchant_id,
    tag_id,
    date_of_transaction,
    amount
  )
  VALUES
  (
    $1,$2,CURRENT_DATE,$3
  )
  RETURNING id
  "
  values = [@merchant_id,@tag_id,@amount]
  result = SqlRunner.run(sql,values)
  @id = result.first()['id'].to_i
end

def self.all()

end

def self.delete_all
  sql =
  "
  DELETE FROM transactions
  "
  SqlRunner.run(sql)
end

def update()

end


end
