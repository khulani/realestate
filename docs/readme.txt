(run in terminal...)
bundle install

(edit file...) config/database.yml
* modify the following info with the appropriate mysql account information
  to grant this project access to create databases and tables:
>>  username: root
>>  password: p@ssw0rd
>>  host: localhost

(run in terminal...)
rake db:create    # creates the databases
rake db:migrate   # creates the tables
rake db:seed      # seeds the database with test data

(run in terminal...)
rake              # runs unit test via rspec


- - - - - - -

Ideally, REST Web Service would be more secure using HTTPS in addition
to requiring an authentication token.
