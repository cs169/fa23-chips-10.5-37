# language: en

Feature: Adding exisiting/not existing rep to db

Scenario: Add an existing representative
  Given a rep named "Silly Sally" does exist in the database
  When I add the rep "Silly Sally"
  Then I should see the rep "Silly Sally" in the database 1 time

Scenario: Add a non-existing representative
  Given a rep named "Willy Wonka" does not exist in the database
  When I add the rep "Willy Wonka"
  Then I should see the rep "Willy Wonka" in the database

## check path type for When I visit ##
#Scenario: Viewing Representative Details
#  Given a rep named "Known Moose" does exist in the database
#  When I visit the reps page
#  And press "Known Moose"
#  Then I should see the name of "Known Moose"
#  And I should see the political party "Democratic"

##  check ID is properlly assigned ## 
Scenrio: Newly added representive should have proper ID 
    Given a representative named "Not Corn" does exist in the database
    And a representative named "Is Corn" does exist in the database
    And a representative named "Maybe Corn" does exist in the database
    And a representative named "Corn Kernal" does not exist in the database
    When I add the representative "Corn Kernal"
    Then I should see the representative "Corn Kernal" in the database
    And “Corn Kernal” should have the id “4”