require_relative('../db/sql_runner')

class Transaction

def initialize(transaction_details)
  @id = transaction_details['id'].to_i if transaction_details['id']
  @amount = transaction_details['amount']
  @date = transaction_details['timestamp']
  @merchant_id = transaction_details['merchant_id']
  @tag_id = transaction_details['tag_id']
end






end
