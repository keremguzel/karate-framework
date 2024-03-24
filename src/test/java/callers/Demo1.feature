Feature: Demo

  Background:
    Given url baseUrl

  @regression @smoke
  Scenario: Get request and status
    * def postCaller = call read('classpath:callers/addPetById.feature')
    * request postCaller
    * path 'pet', 100
    * method GET
    Then print response
    * status 200
    * def deleteCaller = call read('classpath:callers/deletePetById.feature'){id:100}

  @smoke
  Scenario: Post request and status
    When path 'pet'
    * def requestBody =
    """
    {
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
    """
    * request requestBody
    * method POST
    Then status 200
    * match response.id == '#notnull'
    * match response.name == requestBody.name

  Scenario: external JSON file
    * path 'pet'
    * def requestBody = read('classpath:data/pet.json')
    * request requestBody
    When method POST
    Then status 200
    * match response contains {category : {"name": "#string", "id": "#number"}}

  Scenario Outline: Outline basics
    Given path 'pet', <id>
    When method GET
    Then status <status>

    Examples:
      | id  | status |
      | 100 | 200    |
      | 0   | 404    |

  Scenario: Using js file
    When path 'pet'
    * def myString = call read('classpath:data/randomString.js') 5
    * def myRequestBody = read('classpath:data/pet.json')
    * set myRequestBody.name = myString
    * request myRequestBody
    When method POST
    Then status 200
    * print response

  Scenario: Using callers
    * def myCaller = call read('classpath:callers/demo.feature'){id: 100}
    Then match myCaller.responseStatus == 200
    Then match myCaller.id == 2345678