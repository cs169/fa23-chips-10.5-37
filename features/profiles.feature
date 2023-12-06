# language: en

Feature: View information about representatives

Background: 
  Given I am on the representatives page
  Then I should see "Search for a Representative"
  Then I fill in "address" with "94720"
  Then I press "Search"
  Then I should see "Gavin Newsom"

Scenario: Visit Gavin Newsom Profile
  When I follow "Gavin Newsom"
  Then I should see "Governor of California"
  And I should see "Democratic Party"

Scenario: Look at Joe Biden's articles as a guest
  When I click the first News Articles link
  Then I should see "Listing News Articles for"
  And I follow "Add News Article"
  Then I should see "Sign In"