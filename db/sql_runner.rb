require('pg')

class SqlRunner

  def self.run(sql,values = [])
    begin
      # Connect to the database
      db = PG.connect({dbname: 'spend_tracker', host: 'localhost'})
      # Prepare the SQL command
      db.prepare("query", sql)
      # Execute the SQL and get the properties within the values array
      result = db.exec_prepared("query", values)
    #this makes sure that even if connection goes down, it will always try and close the db
    ensure
      #to make sure the db doesnt throw an error
      # Close the DB connection
      db.close() if db != nil
    end
    return result
  end

end
