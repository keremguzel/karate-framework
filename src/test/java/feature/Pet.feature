Feature: Pet API Test

  Background:
    Given url baseUrl


  Scenario Outline: GET request to find a Pet by id
    * def postRequest = call read('classpath:callers/addPetById.feature')
    * request postRequest
    * path 'pet', <id>
    When method GET
    Then status <status>

    Examples:
      | id  | status |
      | 100 | 200    |
      | 0   | 404    |

  Scenario: GET request to find a Pet by status
    * path 'pet/findByStatus'
    * param status = 'available'
    When method GET
    Then status 200
    * match response[0] contains {"id": '#notnull', category : {"id": "#number", "name": "#string"}}

  Scenario: PUT request to update an existing Pet
    * path 'pet'
    When def updateRequest = read('classpath:data/updatedPet.json')
    * request updateRequest
    * method PUT
    Then status 200
    * match response.name == 'Limon'

  Scenario: DELETE request to delete an existing Pet
    * def deleteRequest = call read('classpath:callers/deletePetById.feature') {id: 100}
    * match deleteRequest.responseStatus == 200
    * match deleteRequest.id == 100