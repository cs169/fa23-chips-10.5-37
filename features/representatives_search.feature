# language: en

Feature: Search for representatives based on their location

Background: 
  Given I am on the representatives page
  Then I should see "Search for a Representative"

Scenario: I search for a representative in the zipcode 94720
  When I fill in "address" with "94720"
  And press "Search"
  Then I should see "Gavin Newsom"
  And I should see "Kelli Evans"
  And I should see "Phong La"

Scenario: There is only 1 Gavin Newsom
  When I fill in "address" with "94720"
  And press "Search"
  Then the table should have 26 rows
  When I am on the representatives page
  And I fill in "address" with "94720"
  And press "Search"
  Then the table should have 26 rows

Scenario: Search for representative by inputting State Name
  Given I am on the representatives page
  And I fill in "address" with "California"
  And I press "Search"
  Then I should see "Gavin Newsom"

Scenario: Address is invalid
  When I fill in "address" with "chicken"
  And I press "Search"
  Then I should see "Invalid address"

