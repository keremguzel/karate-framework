Feature: Delete Pet by ID

  Scenario: DELETE request to delete a pet
    Given url baseUrl
    * path 'pet', id
    * header api_key = 'special-key'
    When method DELETE


