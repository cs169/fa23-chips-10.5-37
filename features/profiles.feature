# language: en

Feature: View information about representatives

Background: 
  Given I am on the representatives page
  Then I should see "Search for a Representative"
  Then I fill in "address" with "94720"
  Then I press "Search"
  Then I should see "Gavin Newsom"

