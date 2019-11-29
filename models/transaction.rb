require_relative('../db/sql_runner')
require_relative('./tag')
require_relative('./merchant')

class Transaction

attr_reader :id
attr_accessor :amount, :date, :merchant_id, :tag_id


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
  sql =
  "
  SELECT * FROM transactions
  "
  SqlRunner.run(sql)
end

def self.delete_all
  sql =
  "
  DELETE FROM transactions
  "
  SqlRunner.run(sql)
end

def update()
  sql =
  "
  UPDATE transactions
  SET
  (
    merchant_id,
    tag_id,
    date_of_transaction,
    amount
  ) =
  (
    $1,$2,$3,$4
  )
  WHERE id = $5
  "
  values = [@merchant_id,@tag_id,@date_of_transaction,@amount,@id]
  SqlRunner.run(sql,values)
end

def merchant
  sql = "
  SELECT * FROM merchants
  WHERE id = $1
  "
  values = [@merchant_id]
  result = SqlRunner.run(sql,values)
  return Merchant.new(result.first)
end

def tag
  sql = "
  SELECT * FROM tags
  WHERE id = $1
  "
  values = [@tag_id]
  result = SqlRunner.run(sql,values)
  return Tag.new(result.first)
end

end
