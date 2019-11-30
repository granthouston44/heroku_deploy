require_relative('../db/sql_runner')
require_relative('./tag')
require_relative('./merchant')

class Transaction

  attr_reader :id
  attr_accessor :amount, :date, :merchant_id, :tag_id


  def initialize(transaction_details)
    @id = transaction_details['id'].to_i if transaction_details['id']
    @amount = transaction_details['amount']
    @date = transaction_details['date_of_transaction']
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
    transactions = SqlRunner.run(sql)
    return transactions.map {|transaction| Transaction.new(transaction)}
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

    # def self.sort_by_merchant
    #   sql =
    #   #code that brings back an SQL table containing the merchant name and tag name,
    #   #not jsut the ids, as well as amount and date of transaction
    #   "
    #   SELECT
    #   merchants.merchant_name,
    #   tags.tag_name,
    #   transactions.amount,
    #   transactions.date_of_transaction
    #   FROM transactions
    #   INNER JOIN merchants
    #   ON merchants.id = transactions.merchant_id
    #
    #   INNER JOIN tags
    #   ON tags.id = transactions.tag_id
    #
    #   ORDER BY merchants.merchant_name;
    #   "
    #
    #   result = SqlRunner.run(sql)
    #   #brings back an array of hashes with all the correct strings needed
    #   #as a new transaction object normally takes a merchant/tag_id as an integer
    #   #the result array of hashes would return nil for those properties
    #   #we can access the result hash first though and set the string of the name
    #   # equal to the nil merchant/tag id key so that we now have a transaction object
    #   # that contains the full name of each merchant/tag
    #   result.map do |transaction|
    #     transaction['merchant_id'] = transaction['merchant_name']
    #     transaction['tag_id'] = transaction['tag_name']
    #     Transaction.new(transaction)
    #   end
    # end
    #
    # def self.sort_by_tags
    #   sql =
    #   "
    #   SELECT
    #   merchants.merchant_name,
    #   tags.tag_name,
    #   transactions.amount,
    #   transactions.date_of_transaction
    #   FROM transactions
    #   INNER JOIN merchants
    #   ON merchants.id = transactions.merchant_id
    #
    #   INNER JOIN tags
    #   ON tags.id = transactions.tag_id
    #
    #   ORDER BY tags.tag_name;
    #   "
    #
    #   result = SqlRunner.run(sql)
    #   result.map do |transaction|
    #     transaction['merchant_id'] = transaction['merchant_name']
    #     transaction['tag_id'] = transaction['tag_name']
    #     Transaction.new(transaction)
    #   end
    # end

end
