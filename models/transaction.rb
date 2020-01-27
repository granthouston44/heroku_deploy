require_relative('../db/sql_runner')
require_relative('./tag')
require_relative('./merchant')


class Transaction

  attr_reader :id
  attr_accessor :amount, :date, :merchant_id, :tag_id


  def initialize(transaction_details)
    @id = transaction_details['id'].to_i if transaction_details['id']
    @amount = transaction_details['amount']
    @date = transaction_details['date_of_transaction'] if transaction_details['date_of_transaction']
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
      $1,$2,to_char(CURRENT_DATE, 'DD-MM-YYYY'),$3
    )
    RETURNING id, date_of_transaction
    "
    values = [@merchant_id,@tag_id,@amount]
    result = SqlRunner.run(sql,values)
    @id = result.first()['id'].to_i
    @date = result.first['date_of_transaction']
  end

#when i call Transaction.all
#i want to access the database
#run an sql command that will return everything from the transacations table
#as sql returns an array of hashes, i want to then map out the results into an array
#containing all the transaction objects
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
      values = [@merchant_id,@tag_id,@date,@amount,@id]
      SqlRunner.run(sql,values)
    end

    def self.find(id)
      sql =
      "
      SELECT * FROM transactions
      WHERE id = $1
      "
      values = [id]
      transactions = SqlRunner.run(sql,values).first
      return Transaction.new(transactions)
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

    def self.sort_by_merchant
      sql =
      #code that brings back an SQL table containing the merchant name and tag name,
      #not jsut the ids, as well as amount and date of transaction
      "
      SELECT
      merchants.merchant_name,
      tags.tag_name,
      transactions.id,
      transactions.amount,
      transactions.date_of_transaction
      FROM transactions
      INNER JOIN merchants
      ON merchants.id = transactions.merchant_id

      INNER JOIN tags
      ON tags.id = transactions.tag_id

      ORDER BY merchants.merchant_name;
      "

      result = SqlRunner.run(sql)
      #brings back an array of hashes with all the correct strings needed
      #as a new transaction object normally takes a merchant/tag_id as an integer
      #the result array of hashes would return nil for those properties
      #we can access the result hash first though and set the string of the name
      # equal to the nil merchant/tag id key so that we now have a transaction object
      # that contains the full name of each merchant/tag
      result.map do |transaction|
        transaction['merchant_id'] = transaction['merchant_name']
        transaction['tag_id'] = transaction['tag_name']
        Transaction.new(transaction)
      end
    end

    def self.sort_by_tag
      sql =
      "
      SELECT
      merchants.merchant_name,
      tags.tag_name,
      transactions.id,
      transactions.amount,
      transactions.date_of_transaction
      FROM transactions
      INNER JOIN merchants
      ON merchants.id = transactions.merchant_id

      INNER JOIN tags
      ON tags.id = transactions.tag_id

      ORDER BY tags.tag_name;
      "

      result = SqlRunner.run(sql)
      result.map do |transaction|
        transaction['merchant_id'] = transaction['merchant_name']
        transaction['tag_id'] = transaction['tag_name']
        Transaction.new(transaction)
      end
    end



    def self.sort_by_date
      sql =
      "
      SELECT
      merchants.merchant_name,
      tags.tag_name,
      transactions.id,
      transactions.amount,
      transactions.date_of_transaction
      FROM transactions
      INNER JOIN merchants
      ON merchants.id = transactions.merchant_id

      INNER JOIN tags
      ON tags.id = transactions.tag_id

      ORDER BY TO_DATE(transactions.date_of_transaction,'DD-MM-YYY') DESC;
      "

      result = SqlRunner.run(sql)
      result.map do |transaction|
        transaction['merchant_id'] = transaction['merchant_name']
        transaction['tag_id'] = transaction['tag_name']
        Transaction.new(transaction)
      end
    end

    def self.delete(id)
      sql =
      "
      DELETE FROM transactions
      WHERE id = $1
      "
      values = [id]
      SqlRunner.run(sql, values)
    end

    def self.filter_merchant(merchant_id)
      sql =
      "
      SELECT
      merchants.merchant_name,
      tags.tag_name,
      transactions.id,
      transactions.amount,
      transactions.date_of_transaction
      FROM transactions
      INNER JOIN merchants
      ON merchants.id = transactions.merchant_id

      INNER JOIN tags
      ON tags.id = transactions.tag_id

      WHERE merchant_id = $1
      ORDER BY TO_DATE(transactions.date_of_transaction,'DD-MM-YYY') DESC
      ;
      "
      values = [merchant_id]
      result = SqlRunner.run(sql,values)
      result.map do |transaction|
        transaction['merchant_id'] = transaction['merchant_name']
        transaction['tag_id'] = transaction['tag_name']
        Transaction.new(transaction)
      end
    end

    def self.filter_tag(tag_id)
      sql =
      "
      SELECT
      merchants.merchant_name,
      tags.tag_name,
      transactions.id,
      transactions.amount,
      transactions.date_of_transaction
      FROM transactions
      INNER JOIN merchants
      ON merchants.id = transactions.merchant_id

      INNER JOIN tags
      ON tags.id = transactions.tag_id

      WHERE tag_id = $1
      ORDER BY TO_DATE(transactions.date_of_transaction,'DD-MM-YYY') DESC
      ;
      "
      values = [tag_id]
      result = SqlRunner.run(sql,values)
      result.map do |transaction|
        transaction['merchant_id'] = transaction['merchant_name']
        transaction['tag_id'] = transaction['tag_name']
        Transaction.new(transaction)
      end
    end

    def self.filter_date(transid)
      sql =
      "
      SELECT
      merchants.merchant_name,
      tags.tag_name,
      transactions.id,
      transactions.amount,
      transactions.date_of_transaction
      FROM transactions
      INNER JOIN merchants
      ON merchants.id = transactions.merchant_id

      INNER JOIN tags
      ON tags.id = transactions.tag_id

      WHERE date_of_transaction = $1
      ORDER BY TO_DATE(transactions.date_of_transaction,'DD-MM-YYY') DESC
      ;
      "
      transaction = self.find(transid)
      filterdate = transaction.date
      values = [filterdate]
      result = SqlRunner.run(sql,values)
      result.map do |transaction|
        transaction['merchant_id'] = transaction['merchant_name']
        transaction['tag_id'] = transaction['tag_name']
        Transaction.new(transaction)
      end
    end

    # def self.sort_by_tag(filtered)
    #     filtered = filtered.sort_by {|hash| hash.tag_id}
    #     return filtered
    # end

end
