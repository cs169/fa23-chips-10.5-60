Feature: display a list of representatives when clicking on a county

Scenario: clicking on Orange County, CA in the map
  Given I move to the California Page
  Then I go to the Orange County page
  Then I should see "Biden"
  Then I should see "Harris"

Scenario: clicking on , CA in the map.
  Given I move to the California Page
  Then I go to the Alameda County page
  Then I should see "Biden"
  Then I should not see "Harry"
