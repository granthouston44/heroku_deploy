# Spending Tracker
A simple web app that displays interactions with a PosgreSQL database (CRUD) and web programming using both MVC and RESTful routes 

The app allows a user to track their spending.
A new transaction can be added with chosen date, an assigned Merchant and Tag (i.e. 'groceries')
Merchants, Tags and Transactions can all be edited and transcations can be deleted.
New Merchants and Tags can be added to the database.

## Getting Started
To get the project up and running on your local machine, follow the below instructions:

### Prerequisites
Please make sure that you have the below Ruby gems installed

#### Sinatra

A lightweight Domain Specific Language framework that is used to make Ruby web apps

To install sinatra, run the following in terminal:
```
gem install sinatra
```

#### PostgreSQL

PostgreSQL is a powerful, open source object-relational database system that uses and extends the SQL language combined with many features that safely store and scale the most complicated data workloads.
To install PostgreSql, run the folling in terminal:
```
gem install pg
```

#### MiniTest
minitest provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking.
To install MiniTest
```
gem install minitest
gem install minitest-rg
gem install minitest-reporters
```

### Installing
To get the app running, we will need to:
- Create the database
- Seed the database
- Start the server


#### Creating the database
Enter into the terminal
```
createdb spend_tracker
```
Then to actually create the revelevant tables for the app
```
psql -d spend_tracker -f db/spend_tacker.sql

#### Seeding the database
To confirm that the database is working, we can seed the database with default data that should then be viewed on the webapp.
```
ruby db/seeds.rb
```

#### Start the server
To get the server up and running, now run 
```
ruby app.rb
```

### Launching the app
To enter the app, on your browser of choice browse enter the following URL
> lhttp://localhost:4567/

### Built with
- Ruby 
- Sinatra
- PostgreSQL

### Author
Grant Houston

### Aknowledgement
CodeClan for issuing the project brief and giving me the knowledge required to build
