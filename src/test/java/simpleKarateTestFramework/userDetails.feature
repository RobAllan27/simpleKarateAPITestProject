Feature: fetching User Details
Background:
  * def urlBase = 'https://reqres.in'
  * def loginPath = '/api/login'

Scenario: testing the get call for User Details
 
Given url 'https://reqres.in/api/users/2'
When method GET
Then status 200

Scenario: testing the get call for service subscribers
Given url 'http://localhost:3003/servicesubscribers'
When method GET
Then status 200

Scenario Outline:   As a <description>, I want to get the right response_code <status_code>

Given url 'http://localhost:3003/servicesubscriber/321/address'
And request { id: <username> , name: <name}
And header Content-Type = 'application/json'
And header Accept = 'application/json'
When method POST

Then status 200
* print response
And match $..AusPOSTSampleDeliveryService contains 'A demonstration service for medicine delivery'
And match $..userId contains '#notnull'
And match $..userId contains '#uuid'
And match $..postcode contains '#number'
And match $..realAddress contains '#boolean'
And match $..country contains '#null'
Then response.status == <status_code>
Examples:
         |username |name     | status_code   | description |
         |'johnsmith1@myplace.com.au'    |'john1' | 200           | valid user john1 |
         |'johnsmith2@myplace.com.au'    |'john2' | 200           | valid user john2 |

Scenario: testing the get call for address
Given url 'http://localhost:3003/servicesubscriber/321/address'
When method GET
Then status 200

#will fail with no message body
Scenario: testing the Post call for Address
Given url 'http://localhost:3003/servicesubscriber/321/address'
And request { id: '1234' , name: 'John Smith'}
And header Content-Type = 'application/json'
And header Accept = 'application/json'
When method POST
Then status 200

#will fail with no message body
Scenario: testing the get call for Medicine Delivery
Given url 'http://localhost:3003/servicesubscriber/321/address/medicinedelivery'
And header Content-Type = 'application/json'
And header Accept = 'application/json'
And request { id: '1234' , name: 'John Smith'}
When method POST
Then status 200