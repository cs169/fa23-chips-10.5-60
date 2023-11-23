# frozen_string_literal: true

Given('I move to the California Page') do
  visit '/state/CA'
end

Given('I navigate to the Orange County page') do
  visit '/state/CA/county/059'
end

Given('I navigate to the Orange County representatives page') do
  visit '/representatives'
end
Then('I should see myself be on the California state page') do
  expect(page).to have_current_path('/state/CA')
end
