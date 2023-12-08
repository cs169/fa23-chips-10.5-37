# language: en

Feature: Basic Representative functionality 

Scenario: Add an existing representative
  Given a rep "Silly Sally" does exist in the database
  When I add the rep "Silly Sally"
  Then I should see the rep "Silly Sally" in the database 1 time

Scenario: Add a non-existing representative
  Given a rep "Willy Wonka" doesn't exist in the database
  When I add the rep "Willy Wonka"
  Then I should see the rep "Willy Wonka" in the database

## check path type for When I visit ##
#Scenario: Viewing Representative Details
#  Given a rep "Known Moose" does exist in the database
#  When I visit the reps page
#  And press "Known Moose"
#  Then I should see the name of "Known Moose"
#  And I should see the political party "Democratic"

##  check ID is properlly assigned ## 
#Scenrio: Newly added representive should have proper ID 
#  Given a rep "Not Corn" does exist in the database
#  And a rep "Is Corn" does exist in the database
#  And a rep "Maybe Corn" does exist in the database
#  And a rep "Corn Kernal" doesn't exist in the database
#  When I add the rep "Corn Kernal"
#  Then I should see the rep "Corn Kernal" in the database
#  And the rep with name “Corn Kernal” should have the id “4”