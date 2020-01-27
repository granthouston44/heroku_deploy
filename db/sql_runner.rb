require('pg')

class SqlRunner

  def self.run(sql,values = [])
    begin
      # Connect to the database
      db = PG.connect({dbname: 'd22g14lifffkdl', host: 'ec2-54-174-221-35.compute-1.amazonaws.com',
        port: 5432, user: 'dxecgbdeiexhsx', password: '53f9f79fcd091acca765fae7837790f830b01155035130200fec8a94f7d61ab1'})
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
