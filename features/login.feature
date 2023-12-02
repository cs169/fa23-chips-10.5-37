# language: en

Feature: User login and authentication

Background: Given I am on the login page

Scenario: Google Auth login
  When I am logged into Google
  Then I should be redirected to the home page
  
Scenario: Github login
  When I am logged into Github
  Then I should be redirected to the home page

Scenario: Visit Profile with Github
  When I am logged into Github
  And I am on the user profile page

Scenario: Login redirected when logged in
  When I am logged into Github
  When I go to the login page
  Then I am on the user profile page