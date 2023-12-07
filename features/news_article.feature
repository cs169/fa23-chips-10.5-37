Feature: Issues on News article 

Scenario: Click on Add News Article
  Given I am on the login page
  When I press "Sign in with Google"
  Then I am on the home page
  When I click "CA" on national map page
  When I click on county "Alameda"
  Then the table should have 26 rows
  When I click News Article and arrive at "/representatives/3/news_items"
  Then I should see "Listing News Articles for "
  When I follow "Add News Article"
  Then I should see "Edit news article"


