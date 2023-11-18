Feature: View a representatives page

Scenario: A User can visit a specific representatives page and see their information
  When I visit a representatives page
  Then I should see the representatives contact address, political party and photo
