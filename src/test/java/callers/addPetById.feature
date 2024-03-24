Feature: Add Pet by ID

  Scenario: POST request for adding a pet
    Given url baseUrl
    And path 'pet'
    When def requestBody = read('classpath:data/pet.json')
    * request requestBody
    * method POST