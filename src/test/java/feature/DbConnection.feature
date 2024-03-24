Feature: DB Connection

  Background:
    * def config = { username: 'root', password: 'root', url: 'jdbc:mysql://localhost:3306/test', driverClassName: 'com.mysql.jdbc.Driver' }
    * def DbUtils = Java.type('feature.DbUtils')
    * def db = new DbUtils(config)


  Scenario: DB assertion for first user
    * def student = db.readRows('SELECT * FROM student WHERE id=1')
    Then match student[0].id == 1
    * match student[0].name == 'Enes'
    * match student[0].lastName == 'Turan'


  Scenario: DB assertion for second user
    * def student = db.readRows('SELECT * FROM student WHERE id=2')
    Then match student[0].id == 2
    * match student[0].name == 'Kerem'
    * match student[0].lastName == 'Güzel'