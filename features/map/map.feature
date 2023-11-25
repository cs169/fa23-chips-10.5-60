Feature: display a list of representatives when clicking on a county

Scenario: clicking on Orange County, CA in the map
  Given I move to the California Page
  Then I am not at the Florida page
  Then I go to the Orange County page
  Then I should see "Biden"
  Then I should see "Harris"

Scenario: clicking on Alameda County, CA in the map.
  Given I move to the California Page
  Then I go to the Alameda County page
  Then I should see "Biden"
  Then I should not expect "Don" to be there
  Then I go to the Orange County page
  Then I should see "Don"

Scenario: clicking on FL in the map, I shouldn't be redirected to the representatives page.
  Given I move to the Florida Page
  Then I should see myself be on the Florida state page
  Then I should not expect "Biden" to be there