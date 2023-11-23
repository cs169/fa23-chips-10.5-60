Feature: display a list of representatives when clicking on a county

Scenario: clicking on Orange County, CA in the map
  Given I navigate to the Orange County page
  Then I should see myself be on the California state page
  When I click on the Counties in California button
  Then I go to the Orange County page
  Then I should see "Biden"
  Then I should see "Harris"
