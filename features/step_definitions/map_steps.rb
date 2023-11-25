# frozen_string_literal: true

Given('I move to the California Page') do
  visit '/state/CA'
end

Given('I navigate to the Orange County page') do
  visit '/state/CA/county/059'
end

Given('I move to the Florida Page') do
  visit '/state/FL'
end

Given('I navigate to the Orange County representatives page') do
  visit '/representatives'
end

Then('I should see myself be on the Florida state page') do
  expect(page).to have_current_path('/state/FL')
end
Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end
