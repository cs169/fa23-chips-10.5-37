Feature: User can click on a county and see a list of representatives
  As a user of the app
  I want to click on a state to see the counties of this state
  I want to click on a county to see the list of representatives

Scenario: Homepage appearence
  Given I am on the home page
  Then I should see "National Map"

Scenario: Click on a state
  Given 50 states exist
  And I am on the home page
  When I click "CA" on national map page
  Then I should see "California"

Scenario: Click on Alameda county
  Given I am on the home page
  When I click "CA" on national map page
  When I click on county "Alameda"
  Then the table should have 26 rows

Scenario: Click on SF county
  Given I am on the home page
  When I click "CA" on national map page
  When I click on county "San Francisco"
  Then the table should have 26 rows