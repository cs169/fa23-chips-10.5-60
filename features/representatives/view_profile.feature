Feature: View a representatives page

Scenario: A User can visit a specific representatives page and see their information
  Given I am on a representatives page
  Then I should see the representatives "name", "office", "contact address", and "political party".
