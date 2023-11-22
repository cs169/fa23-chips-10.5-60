Feature: Navigate to a representatives page

Scenario: A user can navigate to a representatives page from the search page
  Given I am on a the search page
  And I see a representatives name
  Then I should see a link to their page
  And I should be able to navigate to their page

Scenario: A user can navigate to a representatives page from the news feed
  Given I am on a the news feed for a particular representative
  And I see a representatives name
  Then I should see a link to their page
  And I should be able to navigate to their page
